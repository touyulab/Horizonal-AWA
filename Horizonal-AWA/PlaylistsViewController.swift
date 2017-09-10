//
//  PlaylistViewController.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class PlaylistsViewController: UIViewController {
    
    var mood: Mood?
    
    fileprivate var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(PlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: "PlaylistsCollectionViewCell")
        }
    }
    
    @IBOutlet dynamic fileprivate weak var imageView: UIImageView! {
        didSet {
            imageView.image = mood?.image
            imageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet dynamic fileprivate  weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = mood?.uppercaseString
            titleLabel.sizeToFit()
        }
    }
    
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
        view.bringSubview(toFront: titleLabel)
        
        initCollectionView()
    }
    
    private func initCollectionView() {
        let size = CGSize(width: 600, height: view.bounds.height)
        let point = CGPoint(x: view.bounds.width-size.width, y: 0)
        let frame = CGRect(origin: point, size: size)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: PlaylistsCollectionViewLayout())
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0)
        // 無限スクロールのために真ん中からスタートさせる
        collectionView.contentOffset.y = 49942
        //        collectionView.contentInset.top = 100
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
    }
}

extension PlaylistsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistsCollectionViewCell", for: indexPath) as! PlaylistsCollectionViewCell
        
        cell.set(playlist: Playlist(title: "夏の恋の歌、楽しい歌", comment: "切なかったり、嬉しかったり、花火見て考えました。とにかくいい曲集めました。", musicList: []))
        // TODO: 根本的に修正する必要あり
        cell.alpha = 0
        return cell
    }
}

extension PlaylistsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // TODO: 根本的に修正する必要あり
        cell.alpha = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
//        let playlistVC = PlaylistsViewController.instantiate(withStoryboard: "Main")
//        playlistVC.mood =  Mood.list[indexPath.item%12]
//        show(playlistVC, sender: self)
    }
}
