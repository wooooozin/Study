//
//  ViewController.swift
//  OddEvenGame
//
//  Created by 효우 on 2022/05/03.
//

/*
 1.게임 시작 버튼을 누르게 되면 컴퓨터가 1에서 10까지 숫자를 랜덤으로 선택한다.
 2.사용자는 가진 구슬 갯수를 걸고 홀짝 중에 하나를 선택한다.
 3.결과값이 화면에 보여진다.
 */

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var computerBallCountLbl: UILabel!
    @IBOutlet weak var userBallCountLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var fistImage: UIImageView!
    
    var comBallCount: Int = 20
    var userBallCount: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        computerBallCountLbl.text = String(comBallCount)
        userBallCountLbl.text = String(userBallCount)
        
        self.imageContainer.isHidden = true
        
       
    }

    @IBAction func gameStartPressed(_ sender: UIButton) {
        
        self.imageContainer.isHidden = false
        
        UIView.animate(withDuration: 3.0) {
            self.fistImage.transform = CGAffineTransform(scaleX: 5, y: 1)
            self.fistImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { _ in
            self.imageContainer.isHidden = true
            self.showAlert()
        }
        
    }
    
    func showAlert() {
        print("게임 시작")
        print(self.getRandom())
        // 경고창 생성
        let alert = UIAlertController.init(title: "GAME START", message: "홀 짝을 선택해주세요", preferredStyle: .alert)
        // 경고창 버튼 생성
        let oddButton = UIAlertAction.init(title: "홀", style: .default) { _ in
            print("홀 버튼을 클릭했습니다.")
            
            guard let input = alert.textFields?.first?.text,
            let value = Int(input) else {
                return
            }
            print("입력한 값은 \(input)입니다.")
            self.winner(count: value, select: "홀")
        }
        
        let evenButton = UIAlertAction.init(title: "짝", style: .default) { _ in
            print("짝 버튼을 클릭했습니다.")
            
            guard let input = alert.textFields?.first?.text else {
                return
            }
            
            print("입력한 값은 \(input)입니다.")
            guard let value = Int(input) else {
                return
            }
            self.winner(count: value, select: "짝")
        }
        
        // 경고창 텍스트필드 추가
        alert.addTextField { textField in
            textField.placeholder = "배팅할 구슬의 개수를 입력해주세요."
            
        }
        
        // 경고창에 버튼 추가
        alert.addAction(oddButton)
        alert.addAction(evenButton)
        
        // 뷰컨트롤러에 보여주기
        self.present(alert, animated: true) {
            print("화면이 출력 되었습니다.")
        }
    }
    
    // 랜덤 숫자 생성
    func getRandom() -> Int {
        return Int(arc4random_uniform(10) + 1)
    }
    
    // 승자 확인
    func winner(count: Int, select: String) {
        
        let com = self.getRandom()
        let comType = com % 2 == 0 ? "짝" : "홀"
        
        
        var result = comType
        
        if comType == select {
            print("User Win")
            result = result + "(User Win)"
            self.resultLbl.text = result
            self.calculatedBalls(winner: "user", count: count)
        } else {
            result = result + "(Com Win)"
            print("Computer Win")
            self.resultLbl.text = result
            self.calculatedBalls(winner: "com", count: count)
        }
        
    }
    
    func calculatedBalls(winner: String, count: Int) {
        if winner == "com" {
            self.userBallCount = self.userBallCount - count
            self.comBallCount = self.comBallCount + count
            
            if self.checkEmpty(balls: self.userBallCount) {
                self.resultLbl.text = "루피가 이겼습니다."
            }
        } else {
            self.comBallCount = self.comBallCount - count
            self.userBallCount = self.userBallCount + count
            
            if self.checkEmpty(balls: self.comBallCount) {
                self.resultLbl.text = "보승이가 이겼습니다"
            }
        }
        
        self.userBallCountLbl.text = "\(self.userBallCount)"
        self.computerBallCountLbl.text = "\(self.comBallCount)"
    }
    
    func checkEmpty(balls: Int) -> Bool {
        return balls == 0
    }
    
}

