//
//  SaveTvViewController.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 12.09.2022.
//

import UIKit
import RealmSwift

class SaveTvAndMovieViewController: UIViewController {
    
    @IBOutlet weak var tableViewFavoriteTV: UITableView!
    
    var arraySaveTvAndMovie: [ObjectMovieAndTv] = []
    let realm = try? Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsSaveCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getValueTV()
        getValueMovie()
        tableViewFavoriteTV.reloadData()
    }
    
    func getValueTV() {
        arraySaveTvAndMovie = DataManagerTV().getValueTV()
    }
    
    func getValueMovie() {
        arraySaveTvAndMovie = DataManagerMovie().getValueMovie()
    }
    
}

extension SaveTvAndMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySaveTvAndMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let arrayOfTVandMovie = arraySaveTvAndMovie[indexPath.row]
        
        guard let cell = tableViewFavoriteTV.dequeueReusableCell(withIdentifier: "\(TableViewCell.self)") as? TableViewCell else { return UITableViewCell() }
        
        cell.titleMovieTV.text = arrayOfTVandMovie.TitleObject
        cell.rating.text = "Rating: \(arrayOfTVandMovie.RatingObject)"
        cell.firstAirDateLableView.text = "Release date: \(arrayOfTVandMovie.ReleaseDataObject)"
        cell.loadPosterMovieTv(url: arrayOfTVandMovie.PosterObject)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let valueDelete = arraySaveTvAndMovie[indexPath.row]
            try? realm?.write {
                self.realm?.delete(valueDelete)
            }
            arraySaveTvAndMovie.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tvViewController = storyboard.instantiateViewController(withIdentifier: "\(TVDetailsViewController.self)") as? TVDetailsViewController {
            let saveValueTv = arraySaveTvAndMovie[indexPath.row]
            tvViewController.tvArrayObject = saveValueTv
            
            navigationController?.pushViewController(tvViewController, animated: true)
        } else if let movieViewController = storyboard.instantiateViewController(withIdentifier: "\(MovieDetailsViewController.self)") as? MovieDetailsViewController {
            
            let saveValueMovie = arraySaveTvAndMovie[indexPath.row]
            movieViewController.movieArrayObject = saveValueMovie
            
            navigationController?.pushViewController(movieViewController, animated: true)
        }
    }
}





