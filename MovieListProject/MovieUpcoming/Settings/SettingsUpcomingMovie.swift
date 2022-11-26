import Foundation
import Alamofire

class SettingsUpcomingMovie {
    
    func loadDataOfUpcomingMovie(completion: @escaping([ResultsOfUpcomingMovie])->()) {
        
        let urlUpMovie = "https://api.themoviedb.org/3/movie/upcoming?api_key=f28226d77e6c2b87d7d08bc99737fd1a&language=en-US&page=1"
        
        AF.request(urlUpMovie, method: .get, parameters: nil).responseDecodable(of: DataOfUpcomingMovie.self) { reciveDataUpMovie in
            let decoder = JSONDecoder()
            if let responceDataUpMovie = reciveDataUpMovie.data {
                if let dataUpcomingMovie = try? decoder.decode(DataOfUpcomingMovie.self, from: responceDataUpMovie) {
                    let sortedUpMovie = dataUpcomingMovie.results?.sorted(by: { firstValue, secondValue in
                        return firstValue.title?.compare(secondValue.title ?? "") == ComparisonResult.orderedAscending
                    })
                    completion(sortedUpMovie ?? [])
                }
            }
        }
    }
}
