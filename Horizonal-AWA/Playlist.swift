//
//  Playlist.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Foundation

struct Playlist {
    let id: Int
    let title: String
    let comment: String
    let musicList: [Music]
    let author: String
    
    init(id: Int = 0, title: String = "", comment: String = "", author: String = "GUEST", musicList: [Music] = []) {
        self.id = id
        self.title = title
        self.comment = comment
        self.musicList = musicList
        self.author = author
    }
}

extension Playlist {
    static func make夏の恋の歌楽しい歌() -> Playlist {
        let CHE_R_RY = Music.makeCHE_R_RY()
        let TT = Music.makeTT()
        let Thinking_out_Loud = Music.makeThinking_out_Loud()
        let ワタリドリ = Music.makeワタリドリ()
        let 前前前世 = Music.make前前前世()
        return Playlist(id: 0,
                        title: "夏の恋の歌、楽しい歌",
                        comment: "切なかったり、嬉しかったり、花火見て考えました。とにかくいい曲集めました。",
                        musicList: [CHE_R_RY,
                                    TT,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    前前前世,
                                    CHE_R_RY,
                                    TT,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    前前前世,
                                    CHE_R_RY,
                                    TT,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    前前前世,
                                    Thinking_out_Loud])
    }
    
    static func make2017夏フェスの思い出() -> Playlist {
        let CHE_R_RY = Music.makeCHE_R_RY()
        let TT = Music.makeTT()
        let Thinking_out_Loud = Music.makeThinking_out_Loud()
        let ワタリドリ = Music.makeワタリドリ()
        return Playlist(id: 1,
                        title: "2017、夏フェスの思い出",
                        comment: "いい歌ばかりです。イチオシの音楽です。",
                        musicList: [Thinking_out_Loud,
                                    ワタリドリ,
                                    CHE_R_RY,
                                    TT,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    CHE_R_RY,
                                    TT,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    CHE_R_RY,
                                    TT,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    CHE_R_RY,
                                    TT])
    }
    
    static func makePOPULAR_SONG() -> Playlist {
        let CHE_R_RY = Music.makeCHE_R_RY()
        let TT = Music.makeTT()
        let Thinking_out_Loud = Music.makeThinking_out_Loud()
        let 前前前世 = Music.make前前前世()
        return Playlist(id: 2,
                        title: "POPULAR SONG",
                        comment: "Taylor Swift / Wiz Khalifa / Maroon 5 / Carly Rae Jepsen / One Direction / ルイス・フォンシ / ダディー",
                        musicList: [前前前世,
                                    TT,
                                    Thinking_out_Loud,
                                    CHE_R_RY,
                                    前前前世,
                                    TT,
                                    Thinking_out_Loud,
                                    CHE_R_RY,
                                    前前前世,
                                    TT,
                                    Thinking_out_Loud,
                                    CHE_R_RY,
                                    前前前世,
                                    TT,
                                    Thinking_out_Loud,
                                    CHE_R_RY])
    }
    
    static func makeBeautifulSunset() -> Playlist {
        let CHE_R_RY = Music.makeCHE_R_RY()
        let TT = Music.makeTT()
        let Thinking_out_Loud = Music.makeThinking_out_Loud()
        let ワタリドリ = Music.makeワタリドリ()
        return Playlist(id: 3,
                        title: "🌸Beautiful sunset🌸",
                        comment: "🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸",
                        musicList: [ワタリドリ,
                                    TT,
                                    Thinking_out_Loud,
                                    CHE_R_RY,
                                    ワタリドリ,
                                    TT,
                                    Thinking_out_Loud,
                                    CHE_R_RY,
                                    ワタリドリ,
                                    TT,
                                    Thinking_out_Loud,
                                    CHE_R_RY,
                                    ワタリドリ,
                                    TT,
                                    Thinking_out_Loud,
                                    CHE_R_RY])
    }
}
