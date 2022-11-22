//
//  TableViewCell.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 08.09.2022.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterMovieTV: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var titleMovieTV: UILabel!
    @IBOutlet weak var firstAirDateLableView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.posterMovieTV.layer.cornerRadius = 15
    }
    
    func configurMovie(with movie: ResultsOfTopMovie) {
        
        self.titleMovieTV.text = movie.title
        self.firstAirDateLableView.text = "Release date: " + (movie.release_date ?? "")
        self.rating.text = "Rating: \(Int(movie.popularity ?? 0))"
        loadPosterMovieTv(url: movie.poster_path)
    }
    
    func configurTV(with tv: ResultsOfTopTV) {
        self.firstAirDateLableView.text = "Release date: \(tv.first_air_date ?? "")"
        self.titleMovieTV.text = tv.name
        self.rating.text = "Rating: \(Int(tv.popularity ?? 0))"
        loadPosterMovieTv(url: tv.poster_path)
    }
    
    func objectConfigur(with tvAndMovie: ObjectMovieAndTv) {
        self.firstAirDateLableView.text = tvAndMovie.ReleaseDataObject
    
    }
    
    func loadPosterMovieTv(url: String?) {
        guard let url = url else { return }
        let imageUrlString = "https://image.tmdb.org/t/p/w200/" + url
        let imageUrl = URL(string: imageUrlString)
        self.posterMovieTV.sd_setImage(with: imageUrl)
    }
}
