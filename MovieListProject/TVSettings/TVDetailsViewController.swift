//
//  TVDetailsViewController.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 10.09.2022.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper
import Alamofire

class TVDetailsViewController: UIViewController {
    
    @IBOutlet weak var tvLableView: UILabel!
    @IBOutlet weak var overviewTVTextLable: UILabel!
    @IBOutlet weak var popularityTVLableView: UILabel!
    @IBOutlet weak var dataReleaseTv: UILabel!
    @IBOutlet weak var languageTv: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var posterTvImageView: UIImageView!
    @IBOutlet weak var tvYuotubePlayer: YTPlayerView!
    
    
    var newValueTv: ResultsOfTopTV?
    var tvArrayObject: ObjectMovieAndTv?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addInfoTV()
        transitionTvFromSaveToDetails()
        loadVideoTv()
        
    }
    
    func loadVideoTv() {
        
        guard let tvIdInt = newValueTv?.id else {return}
        let tvId = String(tvIdInt)
        let urlVideo = "https://api.themoviedb.org/3/tv/\(tvId)/videos?api_key=f28226d77e6c2b87d7d08bc99737fd1a&language=en-US"
        
        AF.request(urlVideo).responseDecodable(of: ModelsVideoTv.self) {
            responceModelsVideo in
            if let data = responceModelsVideo.value?.results {
                self.tvYuotubePlayer.load(withVideoId: data.first?.key ?? "")
                self.tvYuotubePlayer.playVideo()
            }
        }
    }
    
    func addInfoTV() {
        
        self.popularityTVLableView.text = "Rating: \(Int(newValueTv?.popularity ?? 0))"
        self.overviewTVTextLable.text = newValueTv?.overview
        self.tvLableView.text = newValueTv?.name
        self.dataReleaseTv.text = "Release date: \(newValueTv?.first_air_date ?? "")"
        self.languageTv.text = "Language: \(newValueTv?.original_language ?? "")"
        loadPosterTV(url: newValueTv?.backdrop_path)
    }
    
    func transitionTvFromSaveToDetails() {
        
        guard let valueOfTvForObject = tvArrayObject else {return}
        settingButton.isHidden = true
        tvYuotubePlayer.isHidden = true
        tvLableView.text = valueOfTvForObject.TitleObject
        dataReleaseTv.text = "Release date: \(valueOfTvForObject.ReleaseDataObject)"
        languageTv.text = "Language: \(valueOfTvForObject.LanguageObject)"
        popularityTVLableView.text = "Rating: \(valueOfTvForObject.RatingObject)"
        overviewTVTextLable.text = valueOfTvForObject.OverviewObject
        loadPosterTV(url: valueOfTvForObject.PosterObject)
        
    }
    
    private func loadPosterTV(url: String?) {
        guard let url = url else {return}
        let imageUrlString = "https://image.tmdb.org/t/p/w500/" + url
        let imageUrl = URL(string: imageUrlString)
        self.posterTvImageView.sd_setImage(with: imageUrl)
        
    }
    
    @IBAction func pressedSaveTVBatto(_ sender: Any) {
        settingButton.isEnabled = false
        guard let valueOfTv = newValueTv else {return}
        DataManagerTV().saveValueTV(valueOfTv)
    }
}




