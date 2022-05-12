//
//  MovieSearchVC.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/11.
//

import Foundation
import UIKit
import Alamofire



class MovieSearchVC: UIViewController {
    
    var result: [results] = []
    var term = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieSearchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchTableView.delegate = self
        movieSearchTableView.dataSource = self
        searchBar.delegate = self
        
        movieSearchTableView.register(UINib(nibName: "MovieCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCellTableViewCell")
        
        MovieSearchRequest().getMovieSearchData(self)
        hideKeyboardWhenTappedAround()
    }
}

// MARK: - Extension

extension MovieSearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = CellDetailVC.init(nibName: "CellDetailVC", bundle: nil)
        
        movieSearchTableView.deselectRow(at: indexPath, animated: true)
        
        detailVC.movieResult = result[indexPath.row]
        detailVC.modalPresentationStyle = .fullScreen
           
           self.present(detailVC, animated: true, completion: nil)

       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieSearchTableView.dequeueReusableCell(withIdentifier: "MovieCellTableViewCell", for: indexPath) as! MovieCellTableViewCell
        
        cell.title.text = result[indexPath.row].trackName
        cell.desc.text = result[indexPath.row].longDescription
        
        let url = URL(string: result[indexPath.row].artworkUrl100)
        let data = try? Data(contentsOf: url!)
        
        cell.movieImageView.image = UIImage(data: data ?? Data())
        
        let dateString = result[indexPath.row].releaseDate
        let formatter = ISO8601DateFormatter()
        if let isoDate = formatter.date(from: dateString) {
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = myFormatter.string(from: isoDate)
            
            cell.date.text = dateString
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}


extension MovieSearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
                    return
                }
        term = searchText
        MovieSearchRequest().getMovieSearchData(self)
        view.endEditing(true)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
