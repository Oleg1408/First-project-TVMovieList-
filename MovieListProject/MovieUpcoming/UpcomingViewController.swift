//
//  UpcomingViewController.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 19.09.2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    @IBOutlet weak var upcomingMovieCollectionView: UICollectionView!
    @IBOutlet weak var centralTextLable: UILabel!
    
    var settungsUpcomingMovieModel = SettingsUpcomingMovie()
    
    var upMovieArray: [ResultsOfUpcomingMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUpcomingMovie()
        settingsUpcomingMovieCollectionView()
        settingsCentralTextLable()
    }
    
    func settingsCentralTextLable() {
        centralTextLable.text = "Upcoming Movie"
    }
    
    func settingsUpcomingMovieCollectionView() {
        upcomingMovieCollectionView.contentInset = UIEdgeInsets(top: 50, left: 24, bottom: 50, right: 24)
    }
    
    //MARK: - LoadData
    func loadUpcomingMovie() {
        settungsUpcomingMovieModel.loadDataOfUpcomingMovie { resultUpcomingMovie in
            self.upMovieArray = resultUpcomingMovie
            self.upcomingMovieCollectionView.reloadData()
        }
    }
}

// MARK: - SettingsCollection

extension UpcomingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upMovieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = upcomingMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingMovieCollectionViewCell", for: indexPath) as? UpcomingMovieCollectionViewCell {
            cell.configur(with: upMovieArray[indexPath.row])
            return cell
        }
        return UICollectionViewCell ()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieViewController = storyboard.instantiateViewController(withIdentifier: "\(DetailsUpMovieViewController.self)") as? DetailsUpMovieViewController {
            movieViewController.newUpcomingMovieArray = upMovieArray[indexPath.row]
            navigationController?.pushViewController(movieViewController, animated: true)
        }
    }
}

// MARK: - Settings CGSize

extension UpcomingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200 , height: 400)
    }
}
