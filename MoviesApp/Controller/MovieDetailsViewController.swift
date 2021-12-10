//
//  MovieDetails.swift
//  MoviesApp

import Foundation
import UIKit
import Kingfisher


class MovieDetailsViewController: UIViewController {
    var movieID: String?
    var movie: Movie?

    @IBOutlet weak var movieBackdrop: UIImageView!
    
    @IBOutlet weak var textTitle: UILabel!
    
    @IBOutlet weak var textOverview: UILabel!
    
    @IBOutlet weak var textRating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.movieBackdrop.image = UIImage(named: "movieBackdrop")
        movieBackdrop.kf.setImage(with: "\(movie?.backdropPath ?? "")".url)
 
        self.movieBackdrop.alpha = 0
        UIView.animate(withDuration: 5.0, delay: 0, options: UIView.AnimationOptions.showHideTransitionViews, animations: { () -> Void in
            self.movieBackdrop.alpha = 0.65
             }, completion: { (Bool) -> Void in    }
        )
  
        
        movieBackdrop.contentMode = .scaleToFill
        
        textTitle.text = movie?.title
        textOverview.text = movie?.overview
        textRating.text = movie?.voteAverage?.description
        
    }
}
