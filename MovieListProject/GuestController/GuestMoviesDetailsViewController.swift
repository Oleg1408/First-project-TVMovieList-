//
//  GuestDetailsViewController.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 02.10.2022.
//

import UIKit
import SDWebImage

class GuestMovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var guestImageMovie: UIImageView!
    @IBOutlet weak var guestCentralTextLable: UILabel!
    @IBOutlet weak var guestMovieDataReleaseLable: UILabel!
    @IBOutlet weak var guestMovieLanguageLable: UILabel!
    @IBOutlet weak var guestMoviePopularLable: UILabel!
    @IBOutlet weak var guestMovieOverviewLable: UILabel!
    
    var guestNewValueMovie: ResultsOfTopMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guestAddInfoMovie()
        
    }
    
    func guestAddInfoMovie() {
        
        self.guestMoviePopularLable.text = "Rating: \(Int(guestNewValueMovie?.popularity ?? 0))"
        self.guestMovieOverviewLable.text = guestNewValueMovie?.overview
        self.guestCentralTextLable.text = guestNewValueMovie?.title
        self.guestMovieDataReleaseLable.text = "Release date: \(guestNewValueMovie?.release_date ?? "")"
        self.guestMovieLanguageLable.text = "Language: \(guestNewValueMovie?.original_language ?? "")"
        loadPosterGuestMovie(url: guestNewValueMovie?.backdrop_path)
    }
    
    private func loadPosterGuestMovie(url: String?) {
        
        guard let url = url else {return}
        let imageUrlString = "https://image.tmdb.org/t/p/w500/" + url
        let imageUrl = URL(string: imageUrlString)
        self.guestImageMovie.sd_setImage(with: imageUrl)
    }
}

