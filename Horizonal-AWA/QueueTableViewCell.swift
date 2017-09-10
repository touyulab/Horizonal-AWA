//
//  QueueTableViewCell.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/11.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class QueueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jacketImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    
    func set(music: Music) {
        jacketImageView.image = music.jacketImage
        titleLabel.text = music.title
        singerLabel.text = music.singer
    }
}
