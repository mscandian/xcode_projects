//
//  PopularViewController.swift
//  MoviesApp


import UIKit

class PopularViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var movies: [Movie]?
    private var page: Int = 1
    private var totalPage: Int = 0
    private var movieSelected: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.size.width - 5) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 280)
        self.title = "Popular"

        fetchMovies()
    }

    private func fetchMovies(_ page: Int = 1) {
        API.fetchMovies("popular", page: page){ data in
            self.totalPage = data.totalPages
            self.movies = data.results
            self.collectionView.reloadData()
        }
    }
    
    private func loadPages() {
        if page < totalPage {
            page += 1
            OperationQueue.main.addOperation {
                API.fetchMovies("popular", page: self.page) { data in
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

extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovies", for: indexPath) as! MovieCollectionViewCell
        cell.movie = movies?[indexPath.item]
        
        return cell
    }
    
    
}

extension PopularViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let count = movies?.count else {
            fatalError()
        }
        if indexPath.item == count - 1 {
            loadPages()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.movies?[indexPath.item]
        movieSelected = item
        self.performSegue(withIdentifier: "ShowMovieDetails", sender: self)
    }
}
