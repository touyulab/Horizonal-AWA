//
//  MoodViewController.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/06.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit
import Gemini

class TestCollectionViewLayout: UICollectionViewLayout {
    
    private var layoutData = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        
        for i in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            let frame = CGRect(x: i*100, y: i*100, width: 140, height: 110)
            let indexPath = IndexPath(item: i, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            layoutData.append(attributes)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutData
    }
    
    override var collectionViewContentSize: CGSize {
        let height = CGFloat(110 * collectionView!.numberOfItems(inSection: 0))
        return CGSize(width: collectionView!.bounds.width, height: height)
    }
}

class MoodViewController: UIViewController {
    
    @IBOutlet weak var collectionView: GeminiCollectionView! {
        didSet {
//            collectionView.collectionViewLayout = TestCollectionViewLayout()
            collectionView.dataSource = self
            collectionView.delegate = self
            let nib = UINib(nibName: "MoodCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "MoodCollectionViewCell")
            
            collectionView.gemini
                .circleRotationAnimation()
                .radius(300)
                .rotateDirection(.clockwise)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        collectionView.transform = collectionView.transform.rotated(by: 45)
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
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodCollectionViewCell", for: indexPath) as! MoodCollectionViewCell
        self.collectionView.animateCell(cell)
        return cell
    }
}

extension MoodViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}

extension MoodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 142, height: 112)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
