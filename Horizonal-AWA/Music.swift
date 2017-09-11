//
//  Music.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

struct Music {
    let title: String?
    let singer: String?
    let jacketImage: UIImage?
    let url: URL?
}

extension Music {
    static func makeSUMMER_SONG() -> Music {
        let musicPath = Bundle.main.path(forResource: "前前前世", ofType: "m4a")!
        let url = URL(fileURLWithPath: musicPath)
        return Music(title: "SUMMER SONG",
                     singer: "YUI",
                     jacketImage: #imageLiteral(resourceName: "orange-garden-pop"),
                     url: url)
    }
    
    static func makeLike_OHH_AHH() -> Music {
        let musicPath = Bundle.main.path(forResource: "TT", ofType: "m4a")!
        let url = URL(fileURLWithPath: musicPath)
        return Music(title: "Like OOH-AHH -Japanese ver.-",
                     singer: "TWICE",
                     jacketImage: #imageLiteral(resourceName: "#TWICE"),
                     url: url)
    }
    
    static func makeThinking_out_Loud() -> Music {
        let musicPath = Bundle.main.path(forResource: "Thinking-out-Loud", ofType: "m4a")!
        let url = URL(fileURLWithPath: musicPath)
        return Music(title: "Thinking out Loud",
                     singer: "Ed Sheeran",
                     jacketImage: #imageLiteral(resourceName: "X"),
                     url: url)
    }
    
    static func makeワタリドリ() -> Music {
        let musicPath = Bundle.main.path(forResource: "ワタリドリ", ofType: "m4a")!
        let url = URL(fileURLWithPath: musicPath)
        return Music(title: "ワタリドリ",
                     singer: "[Alexandros]",
                     jacketImage: #imageLiteral(resourceName: "ALXD"),
                     url: url)
    }
}
