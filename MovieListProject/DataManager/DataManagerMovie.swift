//
//  DataMnagerMovie.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 17.10.2022.
//

import Foundation
import RealmSwift

struct DataManagerMovie {
    
    let realm = try? Realm()
    
    func saveValueMovie(_ modelMovie: ResultsOfTopMovie) {
        let movie = ObjectMovieAndTv()
        
        movie.PosterObject = modelMovie.poster_path ?? ""
        movie.TitleObject = modelMovie.title ?? ""
        movie.ReleaseDataObject = modelMovie.release_date ?? ""
        movie.LanguageObject = modelMovie.original_language ?? ""
        movie.RatingObject = "\(modelMovie.popularity ?? 0)"
        movie.OverviewObject = modelMovie.overview ?? ""
        
        try? realm?.write {
            realm?.add(movie)
        }
    }
    
    func getValueMovie() -> [ObjectMovieAndTv] {
        var movieValue = [ObjectMovieAndTv]()
        
        guard let movieResults = realm?.objects(ObjectMovieAndTv.self) else {
            return []
        }
        for movie in movieResults {
            movieValue.append(movie)
        }
        return movieValue
    }
}
