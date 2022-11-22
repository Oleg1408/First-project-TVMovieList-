//
//  UpcomingMovieCollectionViewCell.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 19.09.2022.
//

import UIKit
import SDWebImage

class UpcomingMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var upMovieImageView: UIImageView!
    @IBOutlet weak var upMovieLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        settingsUpMovieImageView()
    }
    
    func configur(with upMovie: ResultsOfUpcomingMovie) {
        self.upMovieLable.text = upMovie.title
        loadPosterUpMovie(url: upMovie.poster_path)
    }
    
    private func loadPosterUpMovie(url: String?) {
        guard let url = url else { return }
        let imageUrlString = "https://image.tmdb.org/t/p/w200/" + url
        let imageUrl = URL(string: imageUrlString)
        self.upMovieImageView.sd_setImage(with: imageUrl)
    }
    
    func settingsUpMovieImageView() {
        upMovieImageView.layer.cornerRadius = 40
    }
}

