//
//  MovieDetailsViewController.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 10.09.2022.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieLableView: UILabel!
    @IBOutlet weak var overviewTextLable: UILabel!
    @IBOutlet weak var popularityLableView: UILabel!
    @IBOutlet weak var dataReleaseLable: UILabel!
    @IBOutlet weak var languageMovieLable: UILabel!
    @IBOutlet weak var settingButtonSave: UIButton!
    @IBOutlet weak var posterMovieImageView: UIImageView!
    
    var newValueMovie: ResultsOfTopMovie?
    var movieArrayObject: ObjectMovieAndTv?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addInfoMovie()
        transitionMovieFromSaveToDetails()
    }
    
    func addInfoMovie() {
        
        self.popularityLableView.text = "Rating: \(Int(newValueMovie?.popularity ?? 0))"
        self.overviewTextLable.text = newValueMovie?.overview
        self.movieLableView.text = newValueMovie?.title
        self.dataReleaseLable.text = "Release date: \(newValueMovie?.release_date ?? "")"
        self.languageMovieLable.text = "Language: \(newValueMovie?.original_language ?? "")"
        loadPosterMovie(url: newValueMovie?.backdrop_path)
       
    }
    
    func transitionMovieFromSaveToDetails() {
        
        guard let valueOfMovieOblect = movieArrayObject else {return}
        settingButtonSave.isHidden = true
        movieLableView.text = valueOfMovieOblect.TitleObject
        dataReleaseLable.text = "Release date: \(valueOfMovieOblect.ReleaseDataObject)"
        languageMovieLable.text = "Language: \(valueOfMovieOblect.LanguageObject)"
        popularityLableView.text = "Rating: \(valueOfMovieOblect.RatingObject)"
        overviewTextLable.text = valueOfMovieOblect.OverviewObject
        loadPosterMovie(url: valueOfMovieOblect.PosterObject)
    }
    
    private func loadPosterMovie(url: String?) {
        guard let url = url else {return}
        let imageUrlString = "https://image.tmdb.org/t/p/w500/" + url
        let imageUrl = URL(string: imageUrlString)
        self.posterMovieImageView.sd_setImage(with: imageUrl)
    }
    
    @IBAction func pressedSaveMovieButton(_ sender: Any) {
        settingButtonSave.isEnabled = false
        guard let valueOfMovie = newValueMovie else {return}
        DataManagerMovie().saveValueMovie(valueOfMovie)
    }
}

