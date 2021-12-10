//
//  MovieCollectionViewCell.swift
//  MoviesApp

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    var movie: Movie? {
        didSet{
            if let movie = movie {
                movieImage.kf.setImage(with: "\(movie.posterPath ?? "")".url)
//                print(movie.title)
            }
        }
    }
    @IBOutlet private weak var movieImage: UIImageView!
}

extension String {
    var url: URL? {
        return URL(string: "\(posterUrl)\(self)")
    }
}
