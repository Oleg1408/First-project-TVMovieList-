//
//  GuestTVDetailsViewController.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 02.10.2022.
//

import UIKit
import SDWebImage

class GuestTVDetailsViewController: UIViewController {
    
    @IBOutlet weak var guestTvImageView: UIImageView!
    @IBOutlet weak var guestTvCentralTextLable: UILabel!
    @IBOutlet weak var guestTvDataReleaseLable: UILabel!
    @IBOutlet weak var guestTvLanguageLable: UILabel!
    @IBOutlet weak var guestTvPopularLable: UILabel!
    @IBOutlet weak var guestTvOverViewLable: UILabel!
    @IBOutlet weak var guestTvBlock: UIStackView!
    
    var guestNewValueTv: ResultsOfTopTV?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guestAddInfoTv()
    }
    
    func guestAddInfoTv() {
        
        self.guestTvPopularLable.text = "Rating: \(Int(guestNewValueTv?.popularity ?? 0))"
        self.guestTvOverViewLable.text = guestNewValueTv?.overview
        self.guestTvCentralTextLable.text = guestNewValueTv?.name
        self.guestTvDataReleaseLable.text = "Release date: \(guestNewValueTv?.first_air_date ?? "")"
        self.guestTvLanguageLable.text = "Language: \(guestNewValueTv?.original_language ?? "")"
        loadPosterGuestTv(url: guestNewValueTv?.backdrop_path)
    }
    
    private func loadPosterGuestTv(url: String?) {
        
        guard let url = url else {return}
        let imageUrlString = "https://image.tmdb.org/t/p/w500/" + url
        let imageUrl = URL(string: imageUrlString)
        self.guestTvImageView.sd_setImage(with: imageUrl)
    }
}
