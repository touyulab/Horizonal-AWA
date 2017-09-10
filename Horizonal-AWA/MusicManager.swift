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
    
    var playingMusic: Music {
        return queue[playingIndex]
    }
    
    private init() { }
    
    func set(delegate: AVAudioPlayerDelegate?) {
        audioPlayer.delegate = delegate
    }
    
    func set(playlist: [Music], index: Int) {
        queue = playlist
        playingIndex = index
        guard let url = queue[playingIndex].url else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
        } catch {
            
        }
    }
    
    func set(music: Music) {
        guard let url = music.url else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
        } catch {
            
        }
    }
    
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
        
        guard let url = queue[playingIndex].url else { return }
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
        } catch {
            
        }
        
        play()
    }
    
    func back() {
        
    }
}
