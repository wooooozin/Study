//
//  ResultViewController.swift
//  SimpleGameDalma
//
//  Created by 효우 on 2022/05/05.
//

import UIKit
import AVFoundation

class ResultViewController: UIViewController {
    
    @IBOutlet weak var scoreLbl: UILabel!
    
    var text: String = ""
    var bgmPlayer: AVAudioPlayer?
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        playBackgroundSound()
        scoreLbl.text = "내 점수는 \(text) 입니다."
    }


    @IBAction func toMainBtn(_ sender: UIButton) {
        play(fileName: "pause")
        bgmPlayer?.stop()
        self.view.window?.rootViewController?.dismiss(animated: true)
        self.view.window?.rootViewController?.viewDidLoad()
    }
    
    @IBAction func ratingBtn(_ sender: UIButton) {
        play(fileName: "pause")
        print("공유하기")
        bgmPlayer?.stop()
    }
    
    @IBAction func endBtn(_ sender: UIButton) {
        play(fileName: "pause")
        bgmPlayer?.stop()
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
    
    func playBackgroundSound() {
        let url = Bundle.main.url(forResource: "gameover", withExtension: "mp3")
        if let url = url{
            do {
                bgmPlayer = try AVAudioPlayer(contentsOf: url)
                bgmPlayer!.prepareToPlay()
                bgmPlayer!.play()
                
            } catch let error {
                print(error.localizedDescription)
                
            }
            
        }
    }
}
