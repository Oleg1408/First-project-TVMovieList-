//
//  GuestViewController.swift
//  MovieListProject
//
//  Created by Олег Курбатов on 02.10.2022.
//

import UIKit

class GuestViewController: UIViewController {
    
    @IBOutlet weak var centralTextLable: UILabel!
    @IBOutlet weak var guestSearchBar: UISearchBar!
    @IBOutlet weak var guestSegmentControl: UISegmentedControl!
    @IBOutlet weak var guestTableView: UITableView!
    
    var settingTvModel = GuestSettingTvModel()
    var settingMovieModel = GuestSettingMovieModel()
    
    var guestArrayOfTopMovies: [ResultsOfTopMovie] = []
    var guestArrayOfTopTV: [ResultsOfTopTV] = []
    
    // filter
    var guestFilterMovie = [ResultsOfTopMovie]()
    var guestFilterTV = [ResultsOfTopTV]()
    var isGuestSearching = false
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guestLoadTopMovies()
        guestLoadTopTV()
        registerCell()
    }
    
    // MARK: - Load Data
    
    func guestLoadTopMovies() {
        settingMovieModel.guestLoadTopMovies { resultMovieModel in
            self.guestArrayOfTopMovies = resultMovieModel
            self.guestTableView.reloadData()
        }
    }
    
    func guestLoadTopTV() {
        settingTvModel.guestLoadTopTv { resultTvModel in
            self.guestArrayOfTopTV = resultTvModel
            self.guestTableView.reloadData()
        }
    }
    
    @IBAction func pressButton(_ sender: UISegmentedControl) {
        guestTableView.reloadData()
    }
}

// MARK: - Settings TableView

extension GuestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch guestSegmentControl.selectedSegmentIndex {
        case 0:
            if isGuestSearching {
                return guestFilterMovie.count
            } else {
                return guestArrayOfTopMovies.count
            }
        case 1:
            if isGuestSearching {
                return guestFilterTV.count
            } else {
                return guestArrayOfTopTV.count }
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = guestTableView.dequeueReusableCell(withIdentifier: "\(TableViewCell.self)") as? TableViewCell else { return UITableViewCell ()}
        
        switch guestSegmentControl.selectedSegmentIndex {
        case 0:
            cell.configurMovie(with: guestArrayOfTopMovies[indexPath.row])
            if isGuestSearching {
                cell.configurMovie(with: guestFilterMovie[indexPath.row])}
        case 1:
            cell.configurTV(with: guestArrayOfTopTV[indexPath.row])
            if isGuestSearching {
                cell.configurTV(with: guestFilterTV[indexPath.row])
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    // MARK: - To Details Controller
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let guestMovieViewController = storyboard.instantiateViewController(withIdentifier: "\(GuestMovieDetailsViewController.self)") as? GuestMovieDetailsViewController {
            if let tvViewController = storyboard.instantiateViewController(withIdentifier: "\(GuestTVDetailsViewController.self)") as? GuestTVDetailsViewController {
                
                switch guestSegmentControl.selectedSegmentIndex {
                case 0:
                    guestMovieViewController.guestNewValueMovie = guestArrayOfTopMovies[indexPath.row]
                    if isGuestSearching {
                        guestMovieViewController.guestNewValueMovie = guestFilterMovie[indexPath.row]
                    }
                    navigationController?.pushViewController(guestMovieViewController, animated: true)
                case 1:
                    tvViewController.guestNewValueTv = guestArrayOfTopTV[indexPath.row]
                    if isGuestSearching {
                        tvViewController.guestNewValueTv = guestFilterTV[indexPath.row]
                    }
                    navigationController?.pushViewController(tvViewController, animated: true)
                default:
                    break
                }
            }
        }
    }
}

// MARK: - Settings UISearchBar

extension GuestViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.guestFilterMovie.removeAll()
        
        guard searchText != "" || searchText != " " else {
            return
        }
        
        // Movie
        for value in guestArrayOfTopMovies {
            let textValue = searchText.lowercased()
            let isArraContain = value.title?.lowercased().range(of: textValue)
            
            if isArraContain != nil {
                guestFilterMovie.append(value)
            }
        }
        print(guestFilterMovie)
        
        if searchBar.text == "" {
            
            isGuestSearching = false
            guestTableView.reloadData()
        } else {
            isGuestSearching = true
            guestFilterMovie = guestArrayOfTopMovies.filter({$0.title!.contains(searchBar.text ?? "")})
            guestTableView.reloadData()
        }
        
        // TV
        for valueTv in guestArrayOfTopTV {
            let textValueTv = searchText.lowercased()
            let isArrayContain = valueTv.name?.lowercased().range(of: textValueTv)
            
            if isArrayContain != nil {
                guestFilterTV.append(valueTv)
            }
        }
        
        if searchBar.text == "" {
            isGuestSearching = false
            guestTableView.reloadData()
        } else {
            isGuestSearching = true
            guestFilterTV = guestArrayOfTopTV.filter({$0.name!.contains(searchBar.text ?? "")})
            guestTableView.reloadData()
        }
    }
}
