//
//  MiniPlayerSubWindow.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/11.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MiniPlayerSubWindow: UIWindow {
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
            return nil
        }
        return view
    }
    
    func configure() {
        backgroundColor = .clear
        isHidden = false
    }
}
