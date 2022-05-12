//
//  MovieSearchRequest.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/10.
//

import Foundation
import Alamofire

class MovieSearchRequest {
    
    func getMovieSearchData(_ viewController: MovieSearchVC) {
        let url = "https://itunes.apple.com/search?"
        
        let param: Parameters = [
            "term" : viewController.term,
            "country" : "KR",
            "media" : "movie"
        ]
        
        //HTTP Method: GET
        AF.request(url,
                   method: .get,
                   parameters: param,
                   headers: nil).responseDecodable(of: MovieSearchResponse
                    .self) { response in
            
            switch response.result {
                
            case .success(let response):
                print("성공 DEBUG>> Response \(response) ")
                viewController.result = response.results
                viewController.movieSearchTableView.reloadData()
                
            case .failure(let error):
                print("DEBUG>> Get Error : \(error.localizedDescription)")
            }
        }
    }
}

