//
//  MypageVC.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/12.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon


class MypageVC: UIViewController {
    
    @IBOutlet weak var nickNameLbl: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var unLinkBtn: UIButton!
    
    
    @IBOutlet weak var addCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user()
        
        addCollectionView.delegate = self
        addCollectionView.dataSource = self
        
        addCollectionView.register(UINib(nibName: "AddCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddCollectionViewCell")
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
    
    @IBAction func didTapUnLink(_ sender: UIButton) {
        
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
    
    func user() {
        UserApi.shared.me() { [self](user, error) in
               if let error = error {
                   print(error)
               }
               else {
                   _ = user
                   
                   let nick = user?.kakaoAccount?.profile?.nickname
                   
                   if  nick == nick {
                   self.nickNameLbl.text = "\(nick!)님! 환영합니다!"
                   }
                   
                   if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                                       let data = try? Data(contentsOf: url) {
                                       self.profileImageView.image = UIImage(data: data)
                                   }
               }
           }
    }
    
}

//MARK: - Extesion

extension MypageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = addCollectionView.dequeueReusableCell(withReuseIdentifier: "AddCollectionViewCell", for: indexPath) as! AddCollectionViewCell
                
        return cell
    }

}
