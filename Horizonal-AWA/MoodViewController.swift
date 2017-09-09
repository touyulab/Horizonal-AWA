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
            let nib = UINib(nibName: "MoodCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "MoodCollectionViewCell")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initCollectionView()
    }
    
    private func initCollectionView() {
        let size = CGSize(width: 400, height: view.bounds.height)
        let point = CGPoint(x: view.bounds.width-size.width, y: 0)
        let frame = CGRect(origin: point, size: size)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: MoodCollectionViewLayout())
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0)
        // 無限スクロールのために真ん中からスタートさせる
        collectionView.contentOffset.y = 50092
        view.addSubview(collectionView)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        cell.set(row: indexPath.row%12)
        return cell
    }
    
    private func animateCell(_ cell: UITableViewCell) {
        
    }
}

extension MoodViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(collectionView.contentOffset)
    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.frame
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

extension MoodViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 142, height: 112)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
