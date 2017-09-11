//
//  MusicManager.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/11.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit
import AVFoundation

class MusicManager {
    
    static let shared = MusicManager()
    
    var audioPlayer = AVAudioPlayer()
    var queue: [Music] = []
    
    var playingIndex = 0
//    var playingPlaylist: Playlist?
    var playingPlaylistID: Int = 0
    
    var playingMusic: Music {
        return queue[playingIndex]
    }
    
    private init() { }
    
    private var avAudioPlayerDelegate: AVAudioPlayerDelegate?
    
    func set(delegate: AVAudioPlayerDelegate?) {
        audioPlayer.delegate = avAudioPlayerDelegate
        audioPlayer.delegate = delegate
    }
    
    func set(playlist: Playlist, index: Int) {
        playingPlaylistID = playlist.id
        queue = playlist.musicList
        playingIndex = index
        play(index: playingIndex)
    }
    
    // queueのindex番目を再生する
    func play(index: Int) {
        playingIndex = index
        set(music: queue[index])
        play()
    }
    
    func play() {
        audioPlayer.play()
    }
    
    func pause() {
        audioPlayer.pause()
    }
    
    func next() {
        if playingIndex+1 >= queue.count {
            playingIndex = 0
        } else {
            playingIndex += 1
        }
        
        play(index: playingIndex)
    }
    
    func back() {
        if playingIndex-1 < 0 {
            playingIndex = queue.count-1
        } else {
            playingIndex -= 1
        }
        
        play(index: playingIndex)
    }
    
    private func set(music: Music) {
        guard let url = music.url else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = avAudioPlayerDelegate
            audioPlayer.prepareToPlay()
        } catch {
            
        }
    }
}
