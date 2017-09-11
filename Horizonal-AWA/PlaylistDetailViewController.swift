//
//  PlaylistDetailViewController.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class PlaylistDetailViewController: UIViewController {
    
    var playlist: Playlist?
    
    var musicManager = MusicManager.shared
    
    fileprivate var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: "MusicCollectionViewCell")
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = playlist?.title
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = playlist?.musicList.first?.jacketImage
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel! {
        didSet {
            guard let author = playlist?.author else { return }
            authorLabel.text = "Playlist by \(author)"
        }
    }
    
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let effect = UIBlurEffect(style: .dark)
        for _ in 0...1 {
            let effectView = UIVisualEffectView(effect: effect)
            effectView.frame = UIScreen.main.bounds
            effectView.alpha = 0.6
            view.addSubview(effectView)
        }
        
        // 位置調整
        [titleLabel, authorLabel, starButton, shareButton].forEach { view.bringSubview(toFront: $0) }
        
        initCollectionView()
        
        musicManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    private func initCollectionView() {
        let size = CGSize(width: 600, height: view.bounds.height)
        let point = CGPoint(x: view.bounds.width-size.width, y: 0)
        let frame = CGRect(origin: point, size: size)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: MoodCollectionViewLayout())
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0)
        // 無限スクロールのために真ん中からスタートさせる
        collectionView.contentOffset.y = 50232
        //        collectionView.contentInset.top = 100
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
    }
}

extension PlaylistDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlist?.musicList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCollectionViewCell", for: indexPath) as! MusicCollectionViewCell
        
        cell.set(music: playlist!.musicList[indexPath.item])
        // TODO: 根本的に修正する必要あり
        cell.alpha = 0
        // 再生している曲と同じプレイリスト且つindexが一致したもののタイトルをオレンジにする
        if playlist?.id == musicManager.playingPlaylistID && indexPath.item == musicManager.playingIndex {
            cell.titleLabel.textColor = .awaOrange
        } else {
            cell.titleLabel.textColor = .white
        }
        return cell
    }
}

extension PlaylistDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // TODO: 根本的に修正する必要あり
        cell.alpha = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let playMusicNavigationController = PlayMusicNavigationController.instantiate(withStoryboard: "Main")
//        show(playMusicNavigationController, sender: self)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        musicManager.set(playlist: playlist!, index: indexPath.item)
        if let miniPlayerVC = appDelegate?.miniPlayerSubWindow?.rootViewController as? MiniPlayerViewController {
            miniPlayerVC.showMiniPlayer(animated: true)
        }
        collectionView.reloadData()
    }
}

extension PlaylistDetailViewController: MusicManagerDelegate {
    func changedMusic() {
        collectionView.reloadData()
    }
}
