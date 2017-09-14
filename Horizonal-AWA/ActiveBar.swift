//
//  ActiveBar.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class ActiveBar: UIView {
    
    var points: [CGPoint] = []
    
    convenience init(frame: CGRect, points: [CGPoint]) {
        self.init(frame: frame)
        
        self.points = points
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        UIColor.white.withAlphaComponent(0).setFill()
        UIRectFill(rect)
        
        configure()
    }
    
    private func configure() {
        
        if points.count == 0 {
            return
        }
        
        let path = UIBezierPath()
        path.lineWidth = 4
        path.move(to: points[0])
        points.forEach {
            path.addLine(to: $0)
        }
        UIColor.awaOrange.setStroke()
        path.stroke()
    }
}
