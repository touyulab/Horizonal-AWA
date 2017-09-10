//
//  CyberLine.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

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
