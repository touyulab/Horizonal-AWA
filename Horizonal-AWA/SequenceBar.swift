//
//  SequenceBar.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/11.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class SequenceBar: UIView {
    
    var points: [CGPoint] = []
    
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
        
        initBezierLine()
    }
    
    private func initBezierLine() {
        let path = UIBezierPath()
        let point1 = CGPoint(x: 0, y: bounds.height)
        let point2 = CGPoint(x: bounds.width/3, y: bounds.height/3)
        let point3 = CGPoint(x: bounds.width, y: 0)
        let count = 100
        path.move(to: point1)
        (0...count).forEach {
            let point4 = CGPoint(
                x: point1.x + (point2.x - point1.x) * CGFloat($0) / CGFloat(count),
                y: point1.y + (point2.y - point1.y) * CGFloat($0) / CGFloat(count)
            )
            let point5 = CGPoint(
                x: point2.x + (point3.x - point2.x) * CGFloat($0) / CGFloat(count),
                y: point2.y + (point3.y - point2.y) * CGFloat($0) / CGFloat(count)
            )
            let point6 = CGPoint(
                x: point4.x + (point5.x - point4.x) * CGFloat($0) / CGFloat(count),
                y: point4.y + (point5.y - point4.y) * CGFloat($0) / CGFloat(count)
            )
            path.addLine(to: point6)
            points.append(point6)
        }
        path.addLine(to: point3)
        
        UIColor.lightGray.setStroke()
        path.stroke()
    }
}

enum PlayButtonIcon {
    case playing
    case pause
    
    var image: UIImage {
        switch self {
        case .playing:
            return #imageLiteral(resourceName: "playing")
        case .pause:
            return #imageLiteral(resourceName: "pause")
        }
    }
}

class PlayButton: UIView {
    
    private let size = CGSize(width: 38, height: 38)
    private var view = UIView()
    private var imageView = UIImageView()
    
    var tappedAction: (() -> Void)?
    
    convenience init(frame: CGRect, icon: PlayButtonIcon) {
        self.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = icon.image
        imageView.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
//        imageView.layer.add(CATransition(), forKey: nil)
        view.addSubview(imageView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: frame.origin, size: size))
        
        backgroundColor = UIColor.awaOrange.withAlphaComponent(0.56)
        layer.masksToBounds = true
        layer.cornerRadius = size.width/2
        
        view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 23, height: 23)))
        view.backgroundColor = .awaOrange
        view.center = center
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.bounds.size.width/2
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapped(_ gestureRecognizer: UITapGestureRecognizer) {
        tappedAction?()
    }
    
    func set(icon: PlayButtonIcon) {
        imageView.image = icon.image
    }
}
