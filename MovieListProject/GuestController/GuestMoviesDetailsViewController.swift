import UIKit
import SDWebImage
import Alamofire
import youtube_ios_player_helper

class GuestMovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var guestImageMovie: UIImageView!
    @IBOutlet weak var guestCentralTextLable: UILabel!
    @IBOutlet weak var guestMovieDataReleaseLable: UILabel!
    @IBOutlet weak var guestMovieLanguageLable: UILabel!
    @IBOutlet weak var guestMoviePopularLable: UILabel!
    @IBOutlet weak var guestMovieOverviewLable: UILabel!
    @IBOutlet weak var guestYouTubePlayer: YTPlayerView!
    
    var guestNewValueMovie: ResultsOfTopMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guestAddInfoMovie()
        loadVideoMovie()
        
    }
    
    func loadVideoMovie() {
        
        guard let movieIdInt = guestNewValueMovie?.id else {return}
        let movieId = String(movieIdInt)
        let urlVideo = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=f28226d77e6c2b87d7d08bc99737fd1a&language=en-US"
        
        AF.request(urlVideo).responseDecodable(of: ModelsOfVideoMovie.self) { responseModelsVideo in
            if let data = responseModelsVideo.value?.results {
                self.guestYouTubePlayer.load(withVideoId: data.first?.key ?? "")
                self.guestYouTubePlayer.playVideo()
            }
        }
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

