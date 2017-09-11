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
        playButton = PlayButton(frame: .zero, icon: .pause)
        playButton.center = CGPoint(x: sequenceBar.frame.origin.x, y: sequenceBar.frame.origin.y + sequenceBar.bounds.height)
        view.addSubview(playButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedPlayButton(_:)))
        playButton.addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedPlayButton(_:)))
        playButton.addGestureRecognizer(panGesture)
    }
    
    func tappedPlayButton(_ sender: UITapGestureRecognizer) {
        if musicManager.audioPlayer.isPlaying {
            musicManager.pause()
            playButton.set(icon: .playing)
            playButton.layer.removeAllAnimations()
        } else {
            musicManager.play()
            playButton.set(icon: .pause)
            
//            let convertedPointX = view.convert(playButton.frame.origin, to: sequenceBar).x
//            print(convertedPointX)
            let index = calculatePlayButtonY(x: playButton.center.x).index
            animatePlayButton(count: index)
        }
    }
    
    func pannedPlayButton(_ sender: UIPanGestureRecognizer) {
        playButton.layer.removeAllAnimations()
        let point = sender.translation(in: sequenceBar)
        let newPointX = sender.view!.center.x + point.x
        let convertedPointX = view.convert(CGPoint(x: newPointX, y: 0), to: sequenceBar).x
        // 行き過ぎを防ぐ
//        if convertedPointX < 0 || convertedPointX > sequenceBar.bounds.width-1 {
//            musicManager.audioPlayer.currentTime = musicManager.audioPlayer.duration
//        } else {
//            sender.view!.center.x = newPointX
//            let (index, y) = calculatePlayButtonY(x: sender.view!.center.x)
//            sender.view!.center.y = y
//            if sender.state == .ended {
//                musicManager.audioPlayer.currentTime = musicManager.audioPlayer.duration * TimeInterval(index) / TimeInterval(100)
//                animatePlayButton(count: index)
//            }
//        }
        
        
        if convertedPointX < 0 {
            musicManager.audioPlayer.currentTime = 0
            sender.setTranslation(.zero, in: sequenceBar)
            return
        }
        
        if convertedPointX > sequenceBar.bounds.width-1 {
            musicManager.audioPlayer.currentTime = musicManager.audioPlayer.duration-1
            sender.setTranslation(.zero, in: sequenceBar)
            return
        }
        
        sender.view!.center.x = newPointX
        let (index, y) = calculatePlayButtonY(x: sender.view!.center.x)
        sender.view!.center.y = y
        if sender.state == .ended {
            musicManager.audioPlayer.currentTime = musicManager.audioPlayer.duration * TimeInterval(index) / TimeInterval(100)
            if musicManager.audioPlayer.isPlaying {
                animatePlayButton(count: index)
            }
        }
        sender.setTranslation(.zero, in: sequenceBar)
    }
    
    private func calculatePlayButtonY(x: CGFloat) -> (index: Int, y: CGFloat) {
        var index = 0
        var oldDiff: CGFloat = 10000000
        
        for (i, point) in sequenceBar.points.enumerated() {
            let convertedPoint = sequenceBar.convert(point, to: view)
            let diff = abs(x - convertedPoint.x)
            if oldDiff > diff {
                oldDiff = diff
                index = i
            }
        }
        
        return (index, sequenceBar.convert(sequenceBar.points[index], to: view).y)
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
        musicManager.set(delegate: self)
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
