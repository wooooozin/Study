//
//  MainVC.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/10.
//

import Foundation
import UIKit
import Alamofire

class MainVC: UIViewController  {
   
    
    @IBOutlet weak var movieListTableView: UITableView!
        
    let sections: [String] = ["오늘의 '박스오피스' 랭킹 👀",
                              "주말을 사로잡은 '박스오피스' 🎬",
                              "기대 되는 개봉예정작 🍿"
    ]
    
    var result: [dailyBoxOfficeList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        
        movieListTableView.register(UINib(nibName: "MainTableTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableTableViewCell")
        
        MovieListRequest().getDailyMovieData(self)
    }
    
    

}



// MARK: - Extensions

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = movieListTableView.dequeueReusableCell(withIdentifier: "MainTableTableViewCell", for: indexPath) as! MainTableTableViewCell
        
        cell.gradeLbl.text = result[indexPath.row].rank
        cell.movieTitleLbl.text = result[indexPath.row].movieNm
    
        return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
}

extension MainVC {
    func didSuccess(_ response: MovieListResponse) {
        
    }
}

