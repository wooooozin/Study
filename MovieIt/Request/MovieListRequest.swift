//
//  MovieListRequest.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/10.
//

import Foundation
import Alamofire

// MARK: - 일별 박스오피스

class MovieListRequest {
    
    func getDailyMovieData(_ viewController: MainVC) {
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=8139e4985e5e96ba220e8c10738959c6&targetDt=20220509"
        
        let param: Parameters = [
            "key" : "8139e4985e5e96ba220e8c10738959c6",
            "targetDt" : "20220511"
        ]
        
        //HTTP Method: GET
        AF.request(url,
                   method: .get,
                   parameters: param,
                   headers: nil).responseDecodable(of: DailyMovieListResponse
                    .self) { response in
            
            switch response.result {
                
            case .success(let response):
                print("성공 DEBUG>> Response \(response) ")
                viewController.result = response.boxOfficeResult.dailyBoxOfficeList
                
            case .failure(let error):
                print("DEBUG>> Get Error : \(error.localizedDescription)")
            }
        }
    }
    
}


class WeekMovieListRequest {
    
    func getWeeklyMovieData(_ viewController: MainVC) {
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=8139e4985e5e96ba220e8c10738959c6&targetDt=20220508"
        
        let param: Parameters = [
            "key" : "8139e4985e5e96ba220e8c10738959c6",
            "targetDt" : "20220508"
        ]
        
        //HTTP Method: GET
        AF.request(url,
                   method: .get,
                   parameters: param,
                   headers: nil).responseDecodable(of: WeeklyMovieListResponse
                    .self) { response in
            
            switch response.result {
                
            case .success(let response):
                print("성공 DEBUG>> Response \(response) ")
                viewController.weekResult = response.boxOfficeResult.weeklyBoxOfficeList
                viewController.movieListTableView.reloadData()
               
                
            case .failure(let error):
                print("DEBUG>> Get Error : \(error.localizedDescription)")
            }
        }
    }
    
}

