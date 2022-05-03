//
//  SettingViewController.swift
//  OddEvenGame
//
//  Created by 효우 on 2022/05/03.
//

import UIKit

protocol SettingDelegate {
    func getBallsCount(ballsCount: Int)
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var inputBallCount: UITextField!
    
    var settinDelegate: SettingDelegate?
    var defaultBallsCount = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func chagedValue(_ sender: UIButton) {
        
        guard let ballsStr = self.inputBallCount.text, let balls = Int(ballsStr)  else {
            self.settinDelegate?.getBallsCount(ballsCount: self.defaultBallsCount)
            return
        }
        self.settinDelegate?.getBallsCount(ballsCount: balls)
        self.dismiss(animated: true, completion: nil)
    }
    
}
