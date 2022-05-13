//
//  addCollectionViewCell.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/12.
//

import UIKit
import CoreData

class AddCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var addTitleLbl: UILabel!
    
    @IBOutlet weak var addedBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

}

    @IBAction func didTapRemoved(_ sender: UIButton) {

    }

}
