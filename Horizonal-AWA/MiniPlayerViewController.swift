//
//  MiniPlayerViewController.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/11.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MiniPlayerViewController: UIViewController {
    
    private var musicManager = MusicManager.shared
    private var miniPlayer = UIView()
    
    private var jacketImageView = UIImageView()
    private var titleLabel = UILabel()
    private var playButton = UIButton()
    
    override func loadView() {
        super.loadView()
        
        let view = MiniPlayerView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        makeMiniPlayer()
        
        if musicManager.queue.count > 0 {
            showMiniPlayer(animated: false)
        } else {
            dismissMiniPlayer(animated: false)
        }
    }
    
    private func makeMiniPlayer() {
        miniPlayer = UIView(frame: CGRect(origin: CGPoint(x: 16, y: view.bounds.height - 68 - 16),
                                              size: CGSize(width: 256, height: 68)))
        miniPlayer.backgroundColor = UIColor.black.withAlphaComponent(0.64)
        miniPlayer.layer.masksToBounds = true
        miniPlayer.layer.cornerRadius = 8
        view.addSubview(miniPlayer)
        
        jacketImageView = UIImageView(frame: CGRect(x: 16, y: 16, width: 36, height: 36))
//        jacketImageView.image = musicManager.playingMusic.jacketImage
        jacketImageView.contentMode = .scaleAspectFill
        jacketImageView.layer.masksToBounds = true
        jacketImageView.layer.cornerRadius = 2
        miniPlayer.addSubview(jacketImageView)
        
        titleLabel = UILabel(frame: CGRect(x: 16 + 36 + 16, y: 0, width: 100, height: 12))
        titleLabel.center.y = jacketImageView.center.y
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightBold)
        miniPlayer.addSubview(titleLabel)
        
        playButton = UIButton(frame: CGRect(origin: CGPoint(x: titleLabel.frame.origin4.x + 16, y: 0),
                                                size: CGSize(width: 24, height: 24)))
        playButton.center.y = titleLabel.center.y
        playButton.addTarget(self, action: #selector(tappedPlayButton), for: .touchUpInside)
        miniPlayer.addSubview(playButton)
    }
    
    func dismissMiniPlayer(animated: Bool) {
        if animated {
            
        } else {
            miniPlayer.frame.origin.x = -256
        }
    }
    
    func showMiniPlayer(animated: Bool) {
        // 更新
        jacketImageView.image = musicManager.playingMusic.jacketImage
        jacketImageView.layer.add(CATransition(), forKey: nil)
        titleLabel.text = musicManager.playingMusic.title
        titleLabel.layer.add(CATransition(), forKey: nil)
        let buttonImage = musicManager.audioPlayer.isPlaying ? #imageLiteral(resourceName: "pause2") : #imageLiteral(resourceName: "playing2")
        playButton.setImage(buttonImage, for: .normal)
        
        if animated {
            UIView.animate(withDuration: 0.2, animations: { [weak self] _ in
                self?.miniPlayer.frame.origin.x = 16
            })
        } else {
            miniPlayer.frame.origin.x = 16
        }
    }
    
    func tappedPlayButton() {
        if musicManager.audioPlayer.isPlaying {
            playButton.setImage(#imageLiteral(resourceName: "playing2"), for: .normal)
            musicManager.pause()
        } else {
            playButton.setImage(#imageLiteral(resourceName: "pause2"), for: .normal)
            musicManager.play()
        }
    }
}

class MiniPlayerView: UIView {
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
            return nil
        } else {
            return view
        }
    }
}
