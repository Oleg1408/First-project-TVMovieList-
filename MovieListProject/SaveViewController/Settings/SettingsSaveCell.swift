//
//  SettingsSaveCell.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 31.10.2022.
//

import Foundation
import UIKit

extension SaveTvAndMovieViewController {
    
    func settingsSaveCell() {
        
        let nib = UINib(nibName: "\(TableViewCell.self)", bundle: nil)
        tableViewFavoriteTV.register(nib, forCellReuseIdentifier: "\(TableViewCell.self)")
    }
}
