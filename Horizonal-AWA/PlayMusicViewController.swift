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
    
    @IBOutlet dynamic fileprivate weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = UIColor.white.withAlphaComponent(0)
            tableView.register(QueueTableViewCell.self)
        }
    }
    
    @IBOutlet weak var jacketImageView: UIImageView! {
        didSet {
            jacketImageView.image = musicManager.playingMusic.jacketImage
            jacketImageView.contentMode = .scaleAspectFill
            jacketImageView.layer.masksToBounds = true
            let layer = CALayer()
            layer.frame = jacketImageView.bounds
            layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
            jacketImageView.layer.addSublayer(layer)
        }
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = musicManager.playingMusic.title
        }
    }
    
    @IBOutlet weak var singerLabel: UILabel! {
        didSet {
            singerLabel.text = musicManager.playingMusic.singer
        }
    }
    
    private var backgroundImageView = UIImageView() {
        didSet {
            backgroundImageView.image = musicManager.playingMusic.jacketImage
            backgroundImageView.contentMode = .scaleAspectFill
            view.addSubview(backgroundImageView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView = UIImageView(frame: view.bounds)
        
        // ブラー
        let effect = UIBlurEffect(style: .dark)
        for _ in 0...0 {
            let effectView = UIVisualEffectView(effect: effect)
            effectView.frame = UIScreen.main.bounds
            effectView.alpha = 1
            view.addSubview(effectView)
            view.sendSubview(toBack: effectView)
        }
        
        view.sendSubview(toBack: backgroundImageView)
        
        musicManager.set(delegate: self)
        musicManager.play()
    }
    
    @IBAction func tappedCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedNextButton(_ sender: UIButton) {
        musicManager.next()
        refresh()
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        musicManager.back()
        refresh()
    }
    
    fileprivate func refresh() {
        tableView.reloadData()
        
        titleLabel.text = musicManager.playingMusic.title
        singerLabel.text = musicManager.playingMusic.singer
        jacketImageView.image = musicManager.playingMusic.jacketImage
        jacketImageView.layer.add(CATransition(), forKey: nil)
        backgroundImageView.image = musicManager.playingMusic.jacketImage
        backgroundImageView.layer.add(CATransition(), forKey: nil)
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
            cell.titleLabel.textColor = .awaOrange
        } else {
            cell.titleLabel.textColor = .white
        }
        return cell
    }
}

extension PlayMusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        musicManager.play(index: indexPath.row)
        refresh()
    }
}

extension PlayMusicViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        musicManager.next()
        refresh()
    }
}
