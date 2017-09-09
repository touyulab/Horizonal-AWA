//
//  MoodCollectionViewCell.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/08.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    var label = UILabel()
    @IBOutlet weak var moodImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(label)
//        label.alpha = 0
    }
    
    func set(row: Int) {
        label.text = "\(row)"
        label.sizeToFit()
        
        
        switch row%12 {
        case 0:
            moodImageView.image = #imageLiteral(resourceName: "happy-mood")
        case 1:
            moodImageView.image = #imageLiteral(resourceName: "excited-mood")
        default:
            moodImageView.image = #imageLiteral(resourceName: "happy-mood")
        }
    }
}
