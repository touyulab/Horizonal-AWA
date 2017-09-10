//
//  MoodCollectionViewLayout.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/09.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MoodCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var radius: CGFloat = 300
    var angle: CGFloat = 0.0 {
        didSet {
            transform = CGAffineTransform(translationX: radius * sin(angle), y: radius * cos(angle))
        }
    }
}

class MoodCollectionViewLayout: UICollectionViewLayout {
    
    private var layoutData = [MoodCollectionViewLayoutAttributes]()
    private var radius: CGFloat = 300
    private var angle: CGFloat {
        return .pi
    }
    
    override func prepare() {
        super.prepare()
        
        layoutData.removeAll()
        
        for i in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: i, section: 0)
            let attributes = MoodCollectionViewLayoutAttributes(forCellWith: indexPath)
            let mood = Mood.list[i%Mood.number]
            attributes.size = mood.imageSize
            let contentOffsetY = collectionView!.contentOffset.y
            // 円の中心
            attributes.center = CGPoint(x: collectionView!.bounds.width,
                                        y: collectionView!.bounds.height+contentOffsetY)
            // 角度 300pxスクロールで90度回転
            radius = attributes.radius
            attributes.angle = angle + radian(degree: 90/4) * CGFloat(i) - radian(degree: contentOffsetY*90/radius)
            layoutData.append(attributes)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutData
    }
    
    override var collectionViewContentSize: CGSize {
        let width = collectionView!.bounds.width
        return CGSize(width: width, height: 1060)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
