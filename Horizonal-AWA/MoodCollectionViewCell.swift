//
//  MoodCollectionViewCell.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/08.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moodImageView: UIImageView!
    
    func set(mood: Mood) {
        switch mood {
        case .happy:
            moodImageView.image = #imageLiteral(resourceName: "happy-mood")
        case .excited:
            moodImageView.image = #imageLiteral(resourceName: "excited-mood")
        default:
            moodImageView.image = #imageLiteral(resourceName: "happy-mood")
        }
    }
}
