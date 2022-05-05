//
//  PauseViewController.swift
//  SimpleGameDalma
//
//  Created by 효우 on 2022/05/04.
//

import UIKit
import AVFoundation

class PauseViewController: UIViewController, AVAudioPlayerDelegate {
    
    var player: AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    @IBAction func pushGoOn(_ sender: UIButton) {
        play(fileName: "pause")

        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func pushSetting(_ sender: UIButton) {
        play(fileName: "pause")
        print("게임설정")
    }
    
    @IBAction func pushEndApp(_ sender: UIButton) {
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
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.play()
            
        } catch let error {
            print("\(error.localizedDescription)")
        }
        
    }


}
