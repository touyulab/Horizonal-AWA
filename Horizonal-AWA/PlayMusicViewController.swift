//
//  PlayMusicViewController.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit
import AVFoundation

class PlayMusicViewController: UIViewController {
    
    var musicManager = MusicManager.shared
    
    @IBOutlet dynamic fileprivate weak var tableView: UITableView!
    @IBOutlet weak var jacketImageView: UIImageView!
    
    private var backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0)
        tableView.register(QueueTableViewCell.self)
        
        backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = musicManager.playingMusic.jacketImage
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        
        jacketImageView.image = musicManager.playingMusic.jacketImage
        jacketImageView.contentMode = .scaleAspectFill
        jacketImageView.layer.masksToBounds = true
        let layer = CALayer()
        layer.frame = jacketImageView.bounds
        layer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        jacketImageView.layer.addSublayer(layer)
        
        // ブラー
        let effect = UIBlurEffect(style: .dark)
        for _ in 0...0 {
            let effectView = UIVisualEffectView(effect: effect)
            effectView.frame = UIScreen.main.bounds
            effectView.alpha = 1
            view.addSubview(effectView)
        }
        
        view.bringSubview(toFront: tableView)
        view.bringSubview(toFront: jacketImageView)
        
        musicManager.audioPlayer.delegate = self
        musicManager.play()
        musicManager.audioPlayer.currentTime = TimeInterval(260)
    }
    
    @IBAction func tappedCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension PlayMusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: QueueTableViewCell.self, for: indexPath)
        cell.set(music: musicManager.queue[indexPath.row])
        cell.backgroundColor = .clear
        if indexPath.row == musicManager.playingIndex {
            cell.titleLabel.textColor = .orange
        } else {
            cell.titleLabel.textColor = .white
        }
        return cell
    }
}

extension PlayMusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        musicManager.play(index: indexPath.row)
        musicManager.set(delegate: self)
        tableView.reloadData()
    }
}

extension PlayMusicViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        musicManager.next()
        musicManager.set(delegate: self)
        tableView.reloadData()
    }
}
