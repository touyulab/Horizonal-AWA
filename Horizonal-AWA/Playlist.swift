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
        let SUMMER_SONG = Music.makeSUMMER_SONG()
        let Like_OHH_AHH = Music.makeLike_OHH_AHH()
        let Thinking_out_Loud = Music.makeThinking_out_Loud()
        let ワタリドリ = Music.makeワタリドリ()
        return Playlist(id: 0,
                        title: "夏の恋の歌、楽しい歌",
                        comment: "切なかったり、嬉しかったり、花火見て考えました。とにかくいい曲集めました。",
                        musicList: [SUMMER_SONG,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    SUMMER_SONG,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    SUMMER_SONG,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    SUMMER_SONG,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    ワタリドリ])
    }
    
    static func make2017夏フェスの思い出() -> Playlist {
        let SUMMER_SONG = Music.makeSUMMER_SONG()
        let Like_OHH_AHH = Music.makeLike_OHH_AHH()
        let Thinking_out_Loud = Music.makeThinking_out_Loud()
        let ワタリドリ = Music.makeワタリドリ()
        return Playlist(id: 1,
                        title: "2017、夏フェスの思い出",
                        comment: "いい歌ばかりです。イチオシの音楽です。",
                        musicList: [Thinking_out_Loud,
                                    ワタリドリ,
                                    SUMMER_SONG,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    SUMMER_SONG,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    SUMMER_SONG,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    ワタリドリ,
                                    SUMMER_SONG,
                                    Like_OHH_AHH])
    }
    
    static func makePOPULAR_SONG() -> Playlist {
        let SUMMER_SONG = Music.makeSUMMER_SONG()
        let Like_OHH_AHH = Music.makeLike_OHH_AHH()
        let Thinking_out_Loud = Music.makeThinking_out_Loud()
        return Playlist(id: 2,
                        title: "POPULAR SONG",
                        comment: "Taylor Swift / Wiz Khalifa / Maroon 5 / Carly Rae Jepsen / One Direction / ルイス・フォンシ / ダディー",
                        musicList: [Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    SUMMER_SONG,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    SUMMER_SONG,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    SUMMER_SONG,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    SUMMER_SONG,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    SUMMER_SONG,
                                    Like_OHH_AHH])
    }
    
    static func makeBeautifulSunset() -> Playlist {
        let SUMMER_SONG = Music.makeSUMMER_SONG()
        let Like_OHH_AHH = Music.makeLike_OHH_AHH()
        let Thinking_out_Loud = Music.makeThinking_out_Loud()
        let ワタリドリ = Music.makeワタリドリ()
        return Playlist(id: 2,
                        title: "🌸Beautiful sunset🌸",
                        comment: "🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸",
                        musicList: [ワタリドリ,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    SUMMER_SONG,
                                    ワタリドリ,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    SUMMER_SONG,
                                    ワタリドリ,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    SUMMER_SONG,
                                    ワタリドリ,
                                    Like_OHH_AHH,
                                    Thinking_out_Loud,
                                    SUMMER_SONG])
    }
}
