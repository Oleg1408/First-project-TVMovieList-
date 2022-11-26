//
//  MovieDetailsViewController.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 10.09.2022.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper
import Alamofire

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieLableView: UILabel!
    @IBOutlet weak var overviewTextLable: UILabel!
    @IBOutlet weak var popularityLableView: UILabel!
    @IBOutlet weak var dataReleaseLable: UILabel!
    @IBOutlet weak var languageMovieLable: UILabel!
    @IBOutlet weak var settingButtonSave: UIButton!
    @IBOutlet weak var posterMovieImageView: UIImageView!
    @IBOutlet weak var movieYoutubePlayer: YTPlayerView!
    
    var newValueMovie: ResultsOfTopMovie?
    var movieArrayObject: ObjectMovieAndTv?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addInfoMovie()
        transitionMovieFromSaveToDetails()
        loadMovieVideo()
    }
    
    func loadMovieVideo() {
        guard let movieIdInt = newValueMovie?.id else {return}
        let movieId = String(movieIdInt)
        let urlVideo = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=f28226d77e6c2b87d7d08bc99737fd1a&language=en-US"
        
        AF.request(urlVideo).responseDecodable(of: ModelsOfVideoMovie.self) { responseModelsVideo in
            if let data = responseModelsVideo.value?.results {
                self.movieYoutubePlayer.load(withVideoId: data.first?.key ?? "")
                self.movieYoutubePlayer.playVideo()
            }
        }
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
        movieYoutubePlayer.isHidden = true
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

