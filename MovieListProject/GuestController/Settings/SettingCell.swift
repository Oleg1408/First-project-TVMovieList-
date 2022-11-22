//
//  SettingCell.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 10.10.2022.
//

import Foundation
import UIKit

extension GuestViewController {
    
    func registerCell() {
        let nib = UINib(nibName: "\(TableViewCell.self)", bundle: nil)
        guestTableView.register(nib, forCellReuseIdentifier: "\(TableViewCell.self)")
    }
}
