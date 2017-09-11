//
//  MoodViewController.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/06.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MoodViewController: UIViewController {
    
    fileprivate var moodList: [Mood] = Mood.list
    
    fileprivate var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(MoodCollectionViewCell.self, forCellWithReuseIdentifier: "MoodCollectionViewCell")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initCollectionView() {
        let size = CGSize(width: 400, height: view.bounds.height)
        let point = CGPoint(x: view.bounds.width-size.width, y: 0)
        let frame = CGRect(origin: point, size: size)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: MoodCollectionViewLayout())
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0)
        // 無限スクロールのために真ん中からスタートさせる
        collectionView.contentOffset.y = 49942
//        collectionView.contentInset.top = 100
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
    }
}

extension MoodViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodCollectionViewCell", for: indexPath) as! MoodCollectionViewCell
        
        let mood = moodList[indexPath.item%12]
        cell.set(mood: mood)
        // TODO: 根本的に修正する必要あり
        cell.alpha = 0
        return cell
    }
}

extension MoodViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.visibleCells
            .flatMap { $0 as? MoodCollectionViewCell }
            .forEach { cell in
                cell.moodImageScrollView.contentOffset.x = cell.frame.origin.x/5
                cell.moodImageScrollView.contentOffset.y = (cell.frame.origin.y-scrollView.contentOffset.y)/6 - 4
//                cell.moodImageScrollView.contentOffset.x = cell.frame.origin.x/10
//                cell.moodImageScrollView.contentOffset.y = (cell.frame.origin.y-scrollView.contentOffset.y)/10 - 4

            }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // TODO: 根本的に修正する必要あり
        cell.alpha = 1
        collectionView.visibleCells
            .flatMap { $0 as? MoodCollectionViewCell }
            .forEach { cell in
                cell.moodImageScrollView.contentOffset.x = cell.frame.origin.x/5
                cell.moodImageScrollView.contentOffset.y = (cell.frame.origin.y-collectionView.contentOffset.y)/6 - 4
//                cell.moodImageScrollView.contentOffset.x = cell.frame.origin.x/10
//                cell.moodImageScrollView.contentOffset.y = (cell.frame.origin.y-collectionView.contentOffset.y)/10 - 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        let playlistVC = PlaylistsViewController.instantiate(withStoryboard: "Main")
        playlistVC.mood = moodList[indexPath.item%12]
        show(playlistVC, sender: self)
    }
}
