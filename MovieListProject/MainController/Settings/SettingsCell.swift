//
//  SettingsCell.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 12.10.2022.
//

import Foundation
import UIKit

extension ViewController {
    
    func mainRegisterCell() {
        let nib = UINib(nibName: "\(TableViewCell.self)", bundle: nil)
        tableViewMovie.register(nib, forCellReuseIdentifier: "\(TableViewCell.self)")
    }
}
