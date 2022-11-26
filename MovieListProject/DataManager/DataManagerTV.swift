import Foundation
import RealmSwift

struct DataManagerTV {
    
    let realm = try? Realm()
    
    func saveValueTV(_ modelTV: ResultsOfTopTV) {
        let tv = ObjectMovieAndTv()
        
        tv.PosterObject = modelTV.poster_path ?? ""
        tv.TitleObject = modelTV.name ?? ""
        tv.ReleaseDataObject = modelTV.first_air_date ?? ""
        tv.LanguageObject = modelTV.original_language ?? ""
        tv.RatingObject = "\(modelTV.popularity ?? 0)"
        tv.OverviewObject = modelTV.overview ?? ""
        
        try? realm?.write {
            realm?.add(tv)
        }
    }
    
    func getValueTV() -> [ObjectMovieAndTv] {
        var tvValue = [ObjectMovieAndTv]()
        
        guard let tvResults = realm?.objects(ObjectMovieAndTv.self) else {
            return []
        }
        for tv in tvResults {
            tvValue.append(tv)
        }
        return tvValue
    }
}
