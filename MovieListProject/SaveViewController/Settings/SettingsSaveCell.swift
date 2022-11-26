import Foundation
import UIKit

extension SaveTvAndMovieViewController {
    
    func settingsSaveCell() {
        
        let nib = UINib(nibName: "\(TableViewCell.self)", bundle: nil)
        tableViewFavoriteTV.register(nib, forCellReuseIdentifier: "\(TableViewCell.self)")
    }
}
