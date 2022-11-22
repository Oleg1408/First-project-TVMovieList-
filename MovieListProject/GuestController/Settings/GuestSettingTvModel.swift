//
//  SettingForLoadTV.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 10.10.2022.
//

import Foundation
import Alamofire

class GuestSettingTvModel {
    
    func guestLoadTopTv(completion: @escaping([ResultsOfTopTV])->()) {
        
        let urlTopTV = "https://api.themoviedb.org/3/tv/top_rated?api_key=f28226d77e6c2b87d7d08bc99737fd1a&language=en-US&page=1"
        
        AF.request(urlTopTV, method: .get, parameters: nil).responseDecodable(of: DataOfTopTV.self) { reciveDataTopTV in
            let decoder = JSONDecoder()
            if let responceDataTopTV = reciveDataTopTV.data {
                if let dataTopTV = try? decoder.decode(DataOfTopTV.self, from: responceDataTopTV) {
                    
                    let sortedTV = dataTopTV.results?.sorted(by: { firstValue, secondValue in
                        return firstValue.name?.compare(secondValue.name ?? "") == ComparisonResult.orderedAscending
                    })
                    completion(sortedTV ?? [])
                }
            }
        }
    }
}
