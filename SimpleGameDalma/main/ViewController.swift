//
//  ViewController.swift
//  SimpleGameDalma
//
//  Created by 효우 on 2022/05/03.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var bgmPlayer: AVAudioPlayer?
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundSound()
    }
    
    
    @IBAction func pushStartGame(_ sender: UIButton) {
       play(fileName: "pause")
    
        let gameVC = GameViewController.init(nibName: "GameViewController", bundle: nil)
        gameVC.modalPresentationStyle = .fullScreen
        present(gameVC, animated: true, completion: nil)
        bgmPlayer?.stop()
    }
    
    @IBAction func pushHowToGame(_ sender: Any) {
        play(fileName: "pause")
        
        let howToVc = HowToViewController(nibName: "HowToViewController", bundle: nil)
        howToVc.modalPresentationStyle = .fullScreen
        present(howToVc, animated: true, completion: nil)

    }
    
    @IBAction func pushExit(_ sender: UIButton) {
        play(fileName: "pause")

        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { exit(0) }
        bgmPlayer?.stop()
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
                soundPlayer.delegate = self
                soundPlayer.prepareToPlay()
                soundPlayer.play()
    
            } catch let error {
                print("\(error.localizedDescription)")
            }
    
        }
    
    func playBackgroundSound() {
        let url = Bundle.main.url(forResource: "mainbgm", withExtension: "mp3")
        if let url = url{
            do {
                bgmPlayer = try AVAudioPlayer(contentsOf: url)
                bgmPlayer?.numberOfLoops = -1
                bgmPlayer!.prepareToPlay()
                bgmPlayer!.play()
                
            } catch let error {
                print(error.localizedDescription)
                
            }
            
        }
    }
    
}




