//
//  CellDetailVC.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/12.
//

import UIKit
import AVKit


class CellDetailVC: UIViewController {
    
    var player: AVPlayer?
    var movieResult: results?
    
    @IBOutlet weak var movieView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = movieResult?.trackName
        descLbl.text = movieResult?.longDescription
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let url = movieResult?.previewUrl {
        makePlayer(url: url)
        }
        
    }

    // MARK: - Methods
    
    func makePlayer(url: String) {
        if let avUrl = URL(string: url) {
        self.player = AVPlayer(url: avUrl)
        let playerLayer: AVPlayerLayer = AVPlayerLayer(player: player)
        
        movieView.layer.addSublayer(playerLayer)
        
            playerLayer.frame = self.movieView.bounds
            self.player?.play()
        }
    }

    //MARK: - Actions
    
    @IBAction func didTapClosed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapPause(_ sender: UIButton) {
        player?.pause()
    }
    
    @IBAction func didTapPlay(_ sender: UIButton) {
        player?.play()
    }
    
}
