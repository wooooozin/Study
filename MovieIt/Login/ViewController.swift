//
//  ViewController.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/09.
//

import UIKit
import Alamofire
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class ViewController: UIViewController {

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 유효한 토큰 검사
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    
                    // 사용자 정보를 가져오고 화면전환을 하는 커스텀 메서드
                    self.getUserInfo()
                }
            }
        }
        else {
            //로그인 필요
        }
    }
    
    //MARK: - Actions

    @IBAction func didTapKakaoBtn(_ sender: UIButton) {
        loginKakaoAccount() 
    }
    
    @IBAction func didTapGuestBtn(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") else {return}
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    //MARK: - Kakao Login Methods
//    func loginKakao() {
//          print("loginKakao() called.")
//          // 카카오톡 설치 여부 확인
//          if (UserApi.isKakaoTalkLoginAvailable()) {
//              UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                  if let error = error {
//                      print(error)
//                  }
//                  else {
//                      print("loginWithKakaoTalk() success.")
//
//                      // 회원가입 성공 시 oauthToken 저장가능하다
//                      // _ = oauthToken
//
//                      // 사용자정보를 성공적으로 가져오면 화면전환 한다.
//                      self.getUserInfo()
//                  }
//              }
//          }
//          // 카카오톡 미설치
//          else {
//              print("카카오톡 미설치")
//          }
//      }
    
    func loginKakaoAccount() {
        print("loginKakaoAccount() called.")
        
        // 기본 웹 브라우저를 사용하여 로그인 진행.
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                // 회원가입 성공 시 oauthToken 저장
                 _ = oauthToken
                
                // 사용자정보를 성공적으로 가져오면 화면전환 한다.
                self.getUserInfo()
            }
        }
    }
    
    
}

// MARK: - Extensions

extension ViewController {

//  사용자 정보를 성공적으로 가져오면 화면전환 한다.
    private func getUserInfo() {

        // 사용자 정보 가져오기
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") else {return}
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
