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
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieSearchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchTableView.delegate = self
        movieSearchTableView.dataSource = self
        searchBar.delegate = self
        
        movieSearchTableView.register(UINib(nibName: "MovieCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCellTableViewCell")
        
        
    }
}

// MARK: - Extension
extension MovieSearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieSearchTableView.dequeueReusableCell(withIdentifier: "MovieCellTableViewCell", for: indexPath) as! MovieCellTableViewCell
        
        return cell
    }
    
    
    
}


extension MovieSearchVC: UISearchBarDelegate {
    
}
