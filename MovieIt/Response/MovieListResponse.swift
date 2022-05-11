//
//  MovieListResponse.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/10.
//

import Foundation

//MARK: - 일별 박스오피스 모델

struct MovieListResponse:Decodable {

    var boxOfficeResult: boxOfficeResult

}

struct boxOfficeResult: Decodable {
    var boxofficeType: String
    var showRange: String
    var dailyBoxOfficeList: [dailyBoxOfficeList]
}

struct dailyBoxOfficeList: Decodable {
    var rnum: String
    var rank: String
    var rankInten: String
    var rankOldAndNew: String
    var movieCd: String
    var movieNm: String
    var openDt: String
    var salesAmt: String
    var salesShare: String
    var salesInten: String
    var salesChange: String
    var salesAcc: String
    var audiCnt: String
    var audiInten: String
    var audiChange: String
    var audiAcc: String
    var scrnCnt: String
    var showCnt: String

}




