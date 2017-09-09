//
//  Utility.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/09.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

func radian(degree: CGFloat) -> CGFloat {
    return degree*CGFloat.pi/180
}

func degree(radian: CGFloat) -> CGFloat {
    return radian*180/CGFloat.pi
}

extension CALayer {
    func setAnchorPoint(newAnchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPoint(x: bounds.size.width * newAnchorPoint.x, y: bounds.size.height * newAnchorPoint.y)
        var oldPoint = CGPoint(x: bounds.size.width * self.anchorPoint.x, y: bounds.size.height * self.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = self.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        position.x = newPoint.x
        position.y = newPoint.y
        
        anchorPoint = newAnchorPoint
        self.position = position
    }
}
