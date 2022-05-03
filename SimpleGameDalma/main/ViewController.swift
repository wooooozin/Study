//
//  ViewController.swift
//  SimpleGameDalma
//
//  Created by 효우 on 2022/05/03.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        play(fileName: "mainbgm")
        
    }

    
    @IBAction func pushStartGame(_ sender: UIButton) {
        play(fileName: "pause")
        let gameVC = GameViewController.init(nibName: "GameViewController", bundle: nil)
        gameVC.modalPresentationStyle = .fullScreen
        present(gameVC, animated: true, completion: nil)
    }
    
    @IBAction func pushSettingApp(_ sender: Any) {
        play(fileName: "pause")
        print("설정하기")
    }
    
    @IBAction func pushExit(_ sender: UIButton) {
        play(fileName: "pause")
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { exit(0) }
    }
    
    
    // MARK: - BGM play func
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




