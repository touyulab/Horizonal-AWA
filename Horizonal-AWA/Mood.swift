//
//  Mood.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/09.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

enum Mood: String {
    case happy      = "happy"
    case excited    = "excited"
    case relax      = "relax"
    case love       = "love"
    case sad        = "sad"
    case dark       = "dark"
    case morning    = "morning"
    case sleep      = "sleep"
    case study      = "study"
    case workout    = "workout"
    case party      = "party"
    case drive      = "drive"
    
    static var number: Int {
        return list.count
    }
    
    static var list: [Mood] {
        return [happy, excited, relax, love, sad, dark, morning, sleep, study, workout, party, drive]
    }
    
    var imageSize: CGSize {
//        switch self {
//        case .happy:
//            return CGSize(width: 142, height: 112)
//        case .excited:
//            return CGSize(width: 162, height: 112)
//        default:
//            return CGSize(width: 142, height: 112)
//        }
        return CGSize(width: 162, height: 112)
    }
    
    var uppercaseString: String {
        return self.rawValue.uppercased()
    }
    
    var image: UIImage {
        switch self {
        case .happy:
            return #imageLiteral(resourceName: "happy")
        case .excited:
            return #imageLiteral(resourceName: "excited")
        case .relax:
            return #imageLiteral(resourceName: "relax")
        case .love:
            return #imageLiteral(resourceName: "love")
        case .sad:
            return #imageLiteral(resourceName: "sad")
        case .dark:
            return #imageLiteral(resourceName: "dark")
        case .morning:
            return #imageLiteral(resourceName: "morning")
        case .sleep:
            return #imageLiteral(resourceName: "sleep")
        case .study:
            return #imageLiteral(resourceName: "study")
        case .workout:
            return #imageLiteral(resourceName: "workouot")
        case .party:
            return #imageLiteral(resourceName: "Party")
        case .drive:
            return #imageLiteral(resourceName: "drive")
        }
    }
}
