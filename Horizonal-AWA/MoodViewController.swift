//
//  MoodViewController.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/06.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MoodViewController: UIViewController {
    
    fileprivate var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
//            let nib = UINib(nibName: "MoodCollectionViewCell", bundle: nil)
//            collectionView.register(nib, forCellWithReuseIdentifier: "MoodCollectionViewCell")
            collectionView.register(MoodCollectionViewCell2.self, forCellWithReuseIdentifier: "MoodCollectionViewCell2")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initCollectionView()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodCollectionViewCell2", for: indexPath) as! MoodCollectionViewCell2
        let mood = Mood.list[indexPath.row%Mood.number]
        cell.set(mood: mood)
        return cell
    }
}

extension MoodViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.visibleCells
            .flatMap { $0 as? MoodCollectionViewCell2 }
            .forEach { cell in
                cell.moodImageScrollView.contentOffset.x = cell.frame.origin.x/5
                cell.moodImageScrollView.contentOffset.y = (cell.frame.origin.y-scrollView.contentOffset.y)/6 - 4
            }
    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.frame
//    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.item)
//    }
}
