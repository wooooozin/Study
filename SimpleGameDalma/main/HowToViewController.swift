//
//  HowToViewController.swift
//  SimpleGameDalma
//
//  Created by 효우 on 2022/05/05.
//

import UIKit
import AVFoundation

class HowToViewController: UIViewController {

    @IBOutlet weak var howToLbl: UILabel!
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        howToLbl.text = """
                        가장 아래 블럭과 같은 색을 탭하세요.
                        
                        같은 색을 탭하면 + 10점
                        다른 색을 탭하면 - 5점 입니다.
                        
                        주어진 시간 내 최고의 점수를 받아보세요!
                        """
        
    }

    @IBAction func didTapClosed(_ sender: UIButton) {
        
        play(fileName: "pause")
        dismiss(animated: true, completion: nil)
        
        
    }
    

    //MARK: - BGM play func
   
       func play(fileName: String) {
           let filePath = Bundle.main.url(forResource: fileName, withExtension: "mp3")
   
           guard let path = filePath else {
               return
           }
           do {
               self.player = try AVAudioPlayer(contentsOf: path)
               guard let soundPlayer = self.player else {
                   return
               }
              
               soundPlayer.prepareToPlay()
               soundPlayer.play()
   
           } catch let error {
               print("\(error.localizedDescription)")
           }
   
       }
}
