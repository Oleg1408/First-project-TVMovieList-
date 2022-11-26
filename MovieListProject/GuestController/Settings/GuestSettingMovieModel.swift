import Foundation
import Alamofire

class GuestSettingMovieModel {
    
    func guestLoadTopMovies(completion: @escaping([ResultsOfTopMovie])->()) {
        
        let urlTopMovies = "https://api.themoviedb.org/3/movie/top_rated?api_key=f28226d77e6c2b87d7d08bc99737fd1a&language=en-US&page=1"
        
        AF.request(urlTopMovies, method: .get, parameters: nil).responseDecodable(of: DataOfTopMovies.self) { reciveDataTopMovies in
            let decoder = JSONDecoder()
            if let responceDataTopMovie = reciveDataTopMovies.data {
                if let dataTopMovie = try? decoder.decode(DataOfTopMovies.self, from: responceDataTopMovie) {
                    
                    let sortedMovie = dataTopMovie.results?.sorted(by: { firstValue, secondValue in
                        return firstValue.title?.compare(secondValue.title ?? "") == ComparisonResult.orderedAscending
                    })
                    completion(sortedMovie ?? [])
                }
            }
        }
    }
}
