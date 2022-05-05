//
//  GameViewController.swift
//  SimpleGameDalma
//
//  Created by 효우 on 2022/05/04.
//

import UIKit
import AVFoundation



class GameViewController: UIViewController, AVAudioPlayerDelegate {
    
    var blockArray = [UIImage(named: "redBlock")!, UIImage(named: "yellowBlock")!, UIImage(named: "blueblock")!]
    
    var bgmPlayer: AVAudioPlayer?
    var player: AVAudioPlayer?
    
    var countTimer: Timer?
    var timeCounter: Int = 20
    var blockCounter: Int = 0
    var timer: DispatchSourceTimer?

    
    @IBOutlet weak var q1: UIImageView!
    @IBOutlet weak var q2: UIImageView!
    @IBOutlet weak var q3: UIImageView!
    @IBOutlet weak var q4: UIImageView!
    @IBOutlet weak var q5: UIImageView!
    @IBOutlet weak var q6: UIImageView!
    @IBOutlet weak var q7: UIImageView!
    @IBOutlet weak var q8: UIImageView!
    @IBOutlet weak var q9: UIImageView!
    
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var blockCountLbl: UILabel!
    
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var yellowBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playBackgroundSound()
        //        setTimer()
        newTimer()
        startTimer()
        setImage()
    }
    
    
    // MARK: - Push block Button
    
    @IBAction func didTapRedBtn(_ sender: UIButton) {
        if self.q1.image?.pngData() == UIImage(named: "redBlock")?.pngData() {
            
            checkColor(color: "red")
            play(fileName: "truebtn")
            
        } else {
            play(fileName: "falsebtn")
            blockCounter -= 5
            changeScoreText()
            print("red\(blockCounter)")
        }
    }
    
    @IBAction func didTapYellowBtn(_ sender: UIButton) {
        if self.q1.image?.pngData() == UIImage(named: "yellowBlock")?.pngData() {
            
            checkColor(color: "yellow")
            play(fileName: "truebtn")
            
        } else {
            play(fileName: "falsebtn")
            blockCounter -= 5
            changeScoreText()
            print("yello\(blockCounter)")
        }
    }
    
    @IBAction func didTapBlueBtn(_ sender: UIButton) {
        if self.q1.image?.pngData() == UIImage(named: "blueblock")?.pngData() {
            
            checkColor(color: "blue")
            play(fileName: "truebtn")
            
        } else {
            play(fileName: "falsebtn")
            blockCounter -= 5
            changeScoreText()
            print("blue\(blockCounter)")
            
        }
    }
    
    
    // MARK: - Pause btn
    @IBAction func pushPause(_ sender: UIButton) {
        
        play(fileName: "pause")
//        pauseTimer()
        
        let vc = PauseViewController.init(nibName: "PauseViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
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
    
    func playBackgroundSound() {
        let url = Bundle.main.url(forResource: "gamebgm", withExtension: "mp3")
        if let url = url{
            do {
                bgmPlayer = try AVAudioPlayer(contentsOf: url)
                bgmPlayer?.numberOfLoops = 2
                bgmPlayer!.prepareToPlay()
                bgmPlayer!.play()
                
            } catch let error {
                print(error.localizedDescription)
                
            }
            
        }
    }
    
    // MARK: - Changed timer, score
    //    func setTimer() {
    //        countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changedTimer), userInfo: nil, repeats: true)
    //    }
    //
    //    @objc func changedTimer() {
    //        if timeCounter != 0 {
    //            let strCounter = String(format: "%02d", timeCounter)
    //            timeLbl.text = "00:\(strCounter)"
    //            timeCounter -= 1
    //        }   else if timeCounter == 0 {
    //            bgmPlayer?.stop()
    //            countTimer?.invalidate()
    //            countTimer = nil
    //            print("End")
    //
    //            let vc = ResultViewController.init(nibName: "ResultViewController", bundle: nil)
    //            vc.modalPresentationStyle = .overFullScreen
    //            vc.text = blockCountLbl.text ?? ""
    //            present(vc, animated: true, completion: nil)
    //        }
    //    }
    
    func changeScoreText() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.blockCountLbl.text = "\(self.blockCounter)점"
            }
        }
    }
    
    // MARK: - 이미지 변경
    func changeImage() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.q1.image = self.q2.image
                self.q2.image = self.q3.image
                self.q3.image = self.q4.image
                self.q4.image = self.q5.image
                self.q5.image = self.q6.image
                self.q6.image = self.q7.image
                self.q7.image = self.q8.image
                self.q8.image = self.q9.image
                self.q9.image = self.blockArray.randomElement()
            }
        }
    }
    
    // MARK: - 이미지 메인 설정
    
    func setImage() {
        
        self.q1.image = self.blockArray.randomElement()
        self.q2.image = self.blockArray.randomElement()
        self.q3.image = self.blockArray.randomElement()
        self.q4.image = self.blockArray.randomElement()
        self.q5.image = self.blockArray.randomElement()
        self.q6.image = self.blockArray.randomElement()
        self.q7.image = self.blockArray.randomElement()
        self.q8.image = self.blockArray.randomElement()
        self.q9.image = self.blockArray.randomElement()
        
    }
    
    
    // MARK: - 버튼 데이터 값 확인
    
    func checkColor(color: String) {
        if color == "red" {
            
            blockCounter += 10
            changeImage()
            changeScoreText()
            print("red\(blockCounter)")
            
        } else if color == "yellow" {
            
            blockCounter += 10
            changeImage()
            changeScoreText()
            print("yellow\(blockCounter)")
            
        } else if color == "blue" {
            
            blockCounter += 10
            changeImage()
            changeScoreText()
            print("blue\(blockCounter)")
            
        }
    }
    
    // MARK: - New Timer
    
    public func newTimer() {
                self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
                self.timer?.schedule(deadline: .now(), repeating: 1.0)
            
                self.timer?.setEventHandler(handler: { [self] in
            if timeCounter != 0 {
                let strCounter = String(format: "%02d", self.timeCounter)
                timeLbl.text = "00:\(strCounter)"
                timeCounter -= 1
            }   else if timeCounter == 0 {
                bgmPlayer?.stop()
//                countTimer?.invalidate()
//                countTimer = nil
                stopTimer()
                print("End")
                
                let vc = ResultViewController.init(nibName: "ResultViewController", bundle: nil)
                vc.modalPresentationStyle = .overFullScreen
                vc.text = blockCountLbl.text ?? ""
                present(vc, animated: true, completion: nil)
            }
        })
            }
    
    func startTimer() {
        self.timer?.resume()
    }
    
    func pauseTimer() {
        timer?.suspend()
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
}


