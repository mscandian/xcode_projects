//
//  ViewController.swift
//  MoviesApp

import UIKit

private let identifier = "MovieCell"

class TopRatedViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var movies: [Movie]?
    private var page: Int = 1
    private var totalPages: Int = 0
    private var movieSelected: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.size.width - 5) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 280)
        self.title = "Top Rated"
        
        fetchMovies()
    }
    
    private func fetchMovies(_ page: Int = 1) {
        API.fetchMovies("top_rated", page: page){ data in
            self.totalPages = data.totalPages
            self.movies = data.results
            self.collectionView.reloadData()
//            print(results.page)
        }
    }
    
    private func loadPages() {
        if page < totalPages {
            page += 1
            OperationQueue.main.addOperation {
                API.fetchMovies("top_rated", page: self.page) { data in
                    self.movies? += data.results
                    self.collectionView.reloadData()
                }
            }
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetails" {
            // Aqui vamos adicionar o item que será parte do detalhes
            let vc = segue.destination as? MovieDetailsViewController
//            vc?.movieID = "\(indexCell)" // TODO: ID temporário
            vc?.movie = movieSelected
        }
    }
}

extension TopRatedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MovieCollectionViewCell
        cell.movie = movies?[indexPath.item]
        return cell
    }
}

extension TopRatedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let count = movies?.count else {
            fatalError()
        }
        if indexPath.item == count - 1 {
            self.loadPages()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.movies?[indexPath.item]
        movieSelected = item
        self.performSegue(withIdentifier: "ShowMovieDetails", sender: self)
//        print("\(indexPath.item)!")
    }
}
