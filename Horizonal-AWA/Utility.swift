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

extension Array {
    enum RotateDirection {
        case forward
        case backward
    }
    
    func rotate(direction: RotateDirection) ->  [Element] {
        var array = self
        switch direction {
        case .forward:
            guard let firstItem = first else {
                return array
            }
            array.remove(at: 0)
            array.append(firstItem)
        case .backward:
            guard let lastItem = last else {
                return array
            }
            array.remove(at: count-1)
            array.insert(lastItem, at: 0)
        }
        return array
    }
    
    mutating func rotated(direction: RotateDirection) {
        switch direction {
        case .forward:
            guard let firstItem = first else {
                return
            }
            remove(at: 0)
            append(firstItem)
        case .backward:
            guard let lastItem = last else {
                return
            }
            remove(at: count-1)
            insert(lastItem, at: 0)
        }
    }
}

extension CGRect {
    var origin2: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + size.height)
    }
    
    var origin3: CGPoint {
        return CGPoint(x: origin.x + size.width, y: origin.y + size.height)

    }
    
    var origin4: CGPoint {
        return CGPoint(x: origin.x + size.width, y: origin.y)
    }
}
