import UIKit
import SDWebImage
import youtube_ios_player_helper
import Alamofire

class GuestTVDetailsViewController: UIViewController {
    
    @IBOutlet weak var guestTvImageView: UIImageView!
    @IBOutlet weak var guestTvCentralTextLable: UILabel!
    @IBOutlet weak var guestTvDataReleaseLable: UILabel!
    @IBOutlet weak var guestTvLanguageLable: UILabel!
    @IBOutlet weak var guestTvPopularLable: UILabel!
    @IBOutlet weak var guestTvOverViewLable: UILabel!
    @IBOutlet weak var guestTvYoutubePlayer: YTPlayerView!
    
    var guestNewValueTv: ResultsOfTopTV?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guestAddInfoTv()
        loadVideoTv()
    }
    
    func loadVideoTv() {
        
        guard let tvIdInt = guestNewValueTv?.id else {return}
        let tvId = String(tvIdInt)
        let urlVideo = "https://api.themoviedb.org/3/tv/\(tvId)/videos?api_key=f28226d77e6c2b87d7d08bc99737fd1a&language=en-US"
        
        AF.request(urlVideo).responseDecodable(of: ModelsVideoTv.self) {
            responceModelsVideo in
            if let data = responceModelsVideo.value?.results {
                self.guestTvYoutubePlayer.load(withVideoId: data.first?.key ?? "")
                self.guestTvYoutubePlayer.playVideo()
            }
        }
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
