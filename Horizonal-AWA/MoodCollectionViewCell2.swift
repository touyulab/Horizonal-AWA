//
//  MoodCollectionViewCell2.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/09.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MoodCollectionViewCell2: UICollectionViewCell {
    
    var line1 = UIView()
    var line2 = UIView()
    var titleLabel = UILabel()
    var moodImageView = UIImageView()
    
    var cyberLine = CyberLine()
    
    var title = "" {
        didSet {
            // 初期化
            contentView.subviews.forEach { $0.removeFromSuperview() }
            
            // 順番に注意
            initMoodImageView()
            initBezierLine()
            initTitleLabel()
        }
    }
    
    func set(mood: Mood) {
        title = mood.uppercaseString
    }
    
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: cyberLine.frame.origin.x, y: 0),
                                           size: .zero))
        titleLabel.text = title
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
    
    private func initMoodImageView() {
        let size = CGSize(width: 80, height: 80)
        let x = contentView.bounds.width - size.width
        let y = contentView.bounds.height - size.height
        moodImageView = UIImageView(frame: CGRect(origin: CGPoint(x: x, y: y),
                                                  size: size))
        moodImageView.layer.masksToBounds = true
        moodImageView.layer.cornerRadius = moodImageView.bounds.width/2
        moodImageView.layer.borderWidth = 1
        moodImageView.layer.borderColor = UIColor.white.cgColor
        moodImageView.backgroundColor = UIColor.black.withAlphaComponent(0.4)

        contentView.addSubview(moodImageView)
    }
    
    private func initBezierLine() {
        let angle = radian(degree: 45)
        let moodImageViewRadius = moodImageView.bounds.width/2
        let width = titleLabelWidth()+24*sin(angle)
        let height = 24*sin(angle)
        let size = CGSize(width: width,
                          height: height)
        let x = moodImageView.center.x - moodImageViewRadius*cos(angle) - width
        let y = moodImageView.center.y - moodImageViewRadius*sin(angle) - height
        let origin = CGPoint(x: x, y: y)
        cyberLine = CyberLine(frame: CGRect(origin: origin,
                                            size: size))
        contentView.addSubview(cyberLine)
    }
    
    private func titleLabelWidth() -> CGFloat {
        return makeTitleLabel().bounds.width
    }
}

class CyberLine: UIView {
    
    private var line1Length: CGFloat = 80
    private let line2Length: CGFloat = 24
    private let lineWidth: CGFloat = 1
    private let angle: CGFloat = radian(degree: 45)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isOpaque = false
        line1Length = bounds.width - line2Length*cos(angle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        UIColor.white.withAlphaComponent(0).setFill()
        UIRectFill(rect)
        
        initBezierLine()
    }
    
    private func initBezierLine() {
        let line2 = UIBezierPath()
        line2.move(to: CGPoint(x: bounds.width,
                               y: bounds.height))
        let line2EndPoint = CGPoint(x: bounds.width - line2Length*cos(angle),
                                    y: bounds.height - line2Length*sin(angle))
        line2.addLine(to: line2EndPoint)
        line2.close()
        line2.lineWidth = lineWidth
        
        UIColor.white.setStroke()
        line2.stroke()
        
        let line1 = UIBezierPath()
        // 線の太さ/2分ずれるので調整
        line1.move(to: CGPoint(x: line2EndPoint.x,
                               y: line2EndPoint.y+lineWidth/2))
        line1.addLine(to: CGPoint(x: line2EndPoint.x-line1Length,
                                  y: line2EndPoint.y+lineWidth/2))
        line1.close()
        line1.lineWidth = lineWidth
        
        UIColor.white.setStroke()
        line1.stroke()
    }
}
