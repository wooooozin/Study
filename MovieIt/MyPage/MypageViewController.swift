//
//  MainViewController.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/10.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class MypageViewController: UIViewController {
    
    
    var email: String?
    var nickname: String?
    
    @IBOutlet weak var nickNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    //MARK: - Actions
    
    @IBAction func didTapLogOut(_ sender: UIButton) {
        
        // 로그아웃 : 로그아웃은 API 요청의 성공 여부와 관계없이 토큰을 삭제 처리한다는 점에 유의합니다.
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
                
                // 로그아웃 시 메인으로 보냄
                self.view.window?.rootViewController?.dismiss(animated: true)

                }
            }
        }
    
    
    @IBAction func didTapUnlinked(_ sender: UIButton) {
        // 연결 끊기 : 연결이 끊어지면 기존의 토큰은 더 이상 사용할 수 없으므로, 연결 끊기 API 요청 성공 시 로그아웃 처리가 함께 이뤄져 토큰이 삭제됩니다.
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("unlink() success.")
                
                // 연결끊기 시 메인으로 보냄
                self.view.window?.rootViewController?.dismiss(animated: true)

                }
            }
        }
    }

// MARK: - Extensions
    
    extension MypageViewController {
        private func setUI() {
            // 사용자 정보 보여주기
            if let nickname = nickname {
                nickNameLbl.text = "\(nickname)님 환영합니다."
            } else {
                nickNameLbl.text = "로그인 후 서비스를 이용하세요."
            }
            
            if let emial = email {
                emailLbl.text = "\(emial)님 환영합니다."
            } else {
                emailLbl.text = "이메일 정보 수집을 동의하십시오."
            }
        }
    }

