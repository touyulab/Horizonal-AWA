//
//  MusicCollectionViewCell.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    var titleLabel = UILabel()
    var singerLabel = UILabel()
    var jacketImageView = UIImageView()
    var cyberLine = CyberLine()
    
    var music = Music.makeThinking_out_Loud() {
        didSet {
            contentView.subviews.forEach { $0.removeFromSuperview() }
            
            // 順番に注意
            initJacketImageView()
            initBezierLine()
            initTitleLabel()
            initSingerLabel()
        }
    }
    
    func set(music: Music) {
        self.music = music
    }
    
    private func initJacketImageView() {
        let smallJacketSize = CGSize(width: 64, height: 64)
        jacketImageView.frame = CGRect(origin: CGPoint(x: contentView.bounds.width - smallJacketSize.width,
                                                             y: contentView.bounds.height - smallJacketSize.height),
                                             size: smallJacketSize)
        jacketImageView.image = music.jacketImage
        contentView.addSubview(jacketImageView)
    }
    
    private func initBezierLine() {
        let angle = radian(degree: 45)
        let width = titleLabelWidth()+24*sin(angle)
        let height = 24*sin(angle)
        let size = CGSize(width: width,
                          height: height)
        let x = jacketImageView.frame.origin.x - width
        let y = jacketImageView.frame.origin.y - height
        let origin = CGPoint(x: x, y: y)
        cyberLine = CyberLine(frame: CGRect(origin: origin,
                                            size: size))
        contentView.addSubview(cyberLine)
    }
    
    private func initTitleLabel() {
        titleLabel = makeTitleLabel()
        contentView.addSubview(titleLabel)
    }
    
    private func titleLabelWidth() -> CGFloat {
        return makeTitleLabel().bounds.width
    }
    
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: cyberLine.frame.origin.x, y: 0),
                                               size: .zero))
        titleLabel.text = music.title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        titleLabel.frame.origin.y = cyberLine.frame.origin.y - titleLabel.bounds.height
        return titleLabel
    }
    
    private func initSingerLabel() {
        singerLabel = UILabel(frame: CGRect(origin: CGPoint(x: cyberLine.frame.origin.x, y: 0),
                                            size: .zero))
        singerLabel.text = music.singer
        singerLabel.font = UIFont.systemFont(ofSize: 12)
        singerLabel.textColor = .white
        singerLabel.sizeToFit()
        singerLabel.frame.origin.y = cyberLine.frame.origin.y + 2
        contentView.addSubview(singerLabel)
    }
}
