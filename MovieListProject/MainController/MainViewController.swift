//
//  ViewController.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 07.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewMovie: UITableView!
    @IBOutlet weak var segmentControlMovieTV: UISegmentedControl!
    @IBOutlet weak var searchTitleMovieAndTV: UISearchBar!
    
    var settingsTvModel = SettingsTVModel()
    var settingsMovieModel = SettingsMovieModel()
    
    var arrayOfTopMovies: [ResultsOfTopMovie] = []
    var arrayOfTopTV: [ResultsOfTopTV] = []
    
    // filter
    var filterMovie =  [ResultsOfTopMovie]()
    var filterTv = [ResultsOfTopTV]()
    var isSearching = false
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTopMovies()
        loadTopTV()
        mainRegisterCell()
    }
    
    // MARK: - Load Data
    
    func loadTopMovies() {
        settingsMovieModel.loadMovieData { resultMovie in
            self.arrayOfTopMovies = resultMovie
            self.tableViewMovie.reloadData()
        }
    }
    
    func loadTopTV() {
        settingsTvModel.loadTvModel { resultTv in
            self.arrayOfTopTV = resultTv
            self.tableViewMovie.reloadData()
        }
    }
    
    @IBAction func pressButton(_ sender: UISegmentedControl) {
        tableViewMovie.reloadData()
    }
    
    @IBAction func pressButtonExit(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainController = storyboard.instantiateViewController(withIdentifier: "\(MainNavigationController.self)") as?
            MainNavigationController  {
            self.present(mainController, animated: true, completion: nil)
        }
    }
}

// MARK: - Settings TableView

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentControlMovieTV.selectedSegmentIndex {
        case 0:
            if isSearching {
                return filterMovie.count
            } else {
                return arrayOfTopMovies.count
            }
        case 1:
            if isSearching {
                return filterTv.count
            } else {
                return arrayOfTopTV.count }
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableViewMovie.dequeueReusableCell(withIdentifier: "\(TableViewCell.self)") as? TableViewCell else { return UITableViewCell ()}
        
        switch segmentControlMovieTV.selectedSegmentIndex {
        case 0:
            cell.configurMovie(with: arrayOfTopMovies[indexPath.row])
            if isSearching {
                cell.configurMovie(with: filterMovie[indexPath.row])}
        case 1:
            cell.configurTV(with: arrayOfTopTV[indexPath.row])
            if isSearching {
                cell.configurTV(with: filterTv[indexPath.row])
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    // MARK: - Press To Details
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieViewController = storyboard.instantiateViewController(withIdentifier: "\(MovieDetailsViewController.self)") as? MovieDetailsViewController {
            if let tvViewController = storyboard.instantiateViewController(withIdentifier: "\(TVDetailsViewController.self)") as? TVDetailsViewController {
                
                switch segmentControlMovieTV.selectedSegmentIndex {
                case 0:
                    movieViewController.newValueMovie = arrayOfTopMovies[indexPath.row]
                    if isSearching {
                        movieViewController.newValueMovie = filterMovie[indexPath.row]
                    }
                    navigationController?.pushViewController(movieViewController, animated: true)
                case 1:
                    tvViewController.newValueTv = arrayOfTopTV[indexPath.row]
                    if isSearching {
                        tvViewController.newValueTv = filterTv[indexPath.row]
                    }
                    navigationController?.pushViewController(tvViewController, animated: true)
                default:
                    break
                }
            }
        }
    }
}

// MARK: - UISearchController

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterMovie.removeAll()
        
        guard searchText != "" || searchText != " " else {
            return
        }
        
        // Movie
        for value in arrayOfTopMovies {
            let textValue = searchText.lowercased()
            let isArraContain = value.title?.lowercased().range(of: textValue)
            if isArraContain != nil {
                filterMovie.append(value)
            }
        }
        print(filterMovie)
        
        if searchBar.text == "" {
            isSearching = false
            tableViewMovie.reloadData()
        } else {
            isSearching = true
            filterMovie = arrayOfTopMovies.filter({$0.title!.contains(searchBar.text ?? "")})
            tableViewMovie.reloadData()
        }
        
        // TV
        for valueTv in arrayOfTopTV {
            let textValueTv = searchText.lowercased()
            let isArrayContain = valueTv.name?.lowercased().range(of: textValueTv)
            if isArrayContain != nil {
                filterTv.append(valueTv)
            }
        }
        if searchBar.text == "" {
            isSearching = false
            tableViewMovie.reloadData()
        } else {
            isSearching = true
            filterTv = arrayOfTopTV.filter({$0.name!.contains(searchBar.text ?? "")})
            tableViewMovie.reloadData()
        }
    }
}
