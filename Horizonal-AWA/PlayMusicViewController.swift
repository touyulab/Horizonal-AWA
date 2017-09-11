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
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.layer.masksToBounds = true
            backButton.layer.cornerRadius = backButton.bounds.width/2
            backButton.layer.borderWidth = 1
            backButton.layer.borderColor = UIColor.lightGray.cgColor
//            backButton.layer.setAnchorPoint(newAnchorPoint: CGPoint(x: 0.5, y: 0.5), forView: backButton)
//            backButton.transform = backButton.transform.rotated(by: radian(degree: -45))
        }
    }
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.masksToBounds = true
            nextButton.layer.cornerRadius = backButton.bounds.width/2
            nextButton.layer.borderWidth = 1
            nextButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
        
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
        
        makeSequenceBar()
        makePlayButton()
        
        musicManager.set(delegate: self)
        musicManager.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animatePlayButton(count: 0)
    }
    
    var sequenceBar = SequenceBar()
    var playButton = PlayButton()
    
    private func makeSequenceBar() {
        let nextButtonX = nextButton.frame.origin.x
        let backButtonX = backButton.frame.origin.x
        let nextButtonY = nextButton.frame.origin.y
        let backButtonY = backButton.frame.origin.y
        let r = backButton.bounds.width/2
        let size = CGSize(width: nextButtonX - backButtonX - r*(1 + cos(radian(degree: 60))),
                          height: backButtonY - nextButtonY - r*sin(radian(degree: 60)))
        let point = CGPoint(x: nextButton.frame.origin.x - size.width,
                            y: nextButton.center.y)
        sequenceBar = SequenceBar(frame: CGRect(origin: point, size: size))
        view.addSubview(sequenceBar)
    }
    
    private func makePlayButton() {
        playButton = PlayButton(frame: .zero)
        playButton.center = CGPoint(x: sequenceBar.frame.origin.x, y: sequenceBar.frame.origin.y + sequenceBar.bounds.height)
        view.addSubview(playButton)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedPlayButton(_:)))
        playButton.addGestureRecognizer(gesture)
    }
    
    func tappedPlayButton(_ sender: UITapGestureRecognizer) {
        if self.musicManager.audioPlayer.isPlaying {
            self.musicManager.pause()
        } else {
            self.musicManager.play()
        }
    }
    
    private func animatePlayButton(count: Int) {
        if count > 99 {
            return
        }
        
        UIView.animate(
            withDuration: musicManager.audioPlayer.duration/100,
            delay: 0, options: .allowUserInteraction,
            animations: { [weak self] _ in
                let point = self!.sequenceBar.points[count]
                self?.playButton.center = self!.view.convert(point, from: self!.sequenceBar)
            },
            completion: { [weak self] finished in
                if finished {
                    self?.animatePlayButton(count: count+1)
                }
        })
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
        
        playButton.layer.removeAllAnimations()
        
        playButton.removeFromSuperview()
        makePlayButton()
        animatePlayButton(count: 0)
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
