//
//  MovieCellTableViewCell.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/11.
//

import UIKit
import CoreData
protocol CellDelegate: AnyObject {
    func didFinishSaveData()
}


class MovieCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: - Actions
    
    @IBAction func didTapaddedFavorite(_ sender: UIButton) {
        print(title.text ?? "없음")

        
    }
    
    //MARK: - Methods
}
