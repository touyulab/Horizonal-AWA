//
//  MoodCollectionViewCell.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/09.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    var moodImageScrollView = UIScrollView()
    var moodImageView = UIImageView()
    
    var cyberLine = CyberLine()
    
    var mood = Mood.happy {
        didSet {
            contentView.subviews.forEach { $0.removeFromSuperview() }
            
            // 順番に注意
            initmoodImageScrollView()
            initBezierLine()
            initTitleLabel()
        }
    }
    
    func set(mood: Mood) {
        self.mood = mood
    }
    
    private func initmoodImageScrollView() {
        let size = CGSize(width: 88, height: 88)
        let x = contentView.bounds.width - size.width
        let y = contentView.bounds.height - size.height

        moodImageScrollView = UIScrollView(frame: CGRect(origin: CGPoint(x: x, y: y), size: size))
        moodImageScrollView.layer.masksToBounds = true
        moodImageScrollView.layer.cornerRadius = moodImageScrollView.bounds.width/2
        moodImageScrollView.layer.borderWidth = 1
        moodImageScrollView.layer.borderColor = UIColor.white.cgColor
        moodImageScrollView.contentSize = CGSize(width: 120, height: 120)
        moodImageScrollView.isScrollEnabled = false
        moodImageScrollView.isUserInteractionEnabled = false
        
        moodImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                                  size: CGSize(width: 140, height: 140)))
        moodImageView.image = mood.image
        moodImageView.contentMode = .scaleAspectFill
        let blackLayer = makeBlackLayer(frame: moodImageView.bounds)
        moodImageView.layer.addSublayer(blackLayer)
        moodImageScrollView.addSubview(moodImageView)
        contentView.addSubview(moodImageScrollView)
    }
    
    private func makeBlackLayer(frame: CGRect) -> CALayer {
        let blackLayer = CALayer()
        blackLayer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        blackLayer.frame = frame
        return blackLayer
    }
    
    private func initBezierLine() {
        let angle = radian(degree: 45)
        let moodImageScrollViewRadius = moodImageScrollView.bounds.width/2
        let width = titleLabelWidth()+24*sin(angle)
        let height = 24*sin(angle)
        let size = CGSize(width: width,
                          height: height)
        let x = moodImageScrollView.center.x - moodImageScrollViewRadius*cos(angle) - width
        let y = moodImageScrollView.center.y - moodImageScrollViewRadius*sin(angle) - height
        let origin = CGPoint(x: x, y: y)
        cyberLine = CyberLine(frame: CGRect(origin: origin,
                                            size: size))
        contentView.addSubview(cyberLine)
    }
    
    private func titleLabelWidth() -> CGFloat {
        return makeTitleLabel().bounds.width
    }
    
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: cyberLine.frame.origin.x, y: 0),
                                           size: .zero))
        titleLabel.text = mood.uppercaseString
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        titleLabel.frame.origin.y = cyberLine.frame.origin.y - titleLabel.bounds.height + 2
        return titleLabel
    }
    
    private func initTitleLabel() {
        titleLabel = makeTitleLabel()
        contentView.addSubview(titleLabel)
    }
}
