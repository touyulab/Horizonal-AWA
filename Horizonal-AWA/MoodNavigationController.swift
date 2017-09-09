//
//  MoodNavigationController.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/07.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MoodNavigationController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
