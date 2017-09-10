//
//  PlaylistsCollectionViewLayout.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class PlaylistsCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var radius: CGFloat = 400
    var angle: CGFloat = 0.0 {
        didSet {
            transform = CGAffineTransform(translationX: radius * sin(angle), y: radius*3/4 * cos(angle))
        }
    }
}

class PlaylistsCollectionViewLayout: UICollectionViewLayout {
    
    private var layoutData = [PlaylistsCollectionViewLayoutAttributes]()
    private var radius: CGFloat = 400
    private var angle: CGFloat {
        return .pi
    }
    
    override func prepare() {
        super.prepare()
        
        layoutData.removeAll()
        
        for i in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: i, section: 0)
            let attributes = PlaylistsCollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.size = CGSize(width: 386, height: 180)
            let contentOffsetY = collectionView!.contentOffset.y
            // 円の中心
            attributes.center = CGPoint(x: collectionView!.bounds.width,
                                        y: collectionView!.bounds.height+contentOffsetY)
            // 角度 300pxスクロールで90度回転
            radius = attributes.radius
            attributes.angle = angle + radian(degree: 36) * CGFloat(i) - radian(degree: contentOffsetY*90/radius)
            layoutData.append(attributes)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutData
    }
    
    override var collectionViewContentSize: CGSize {
        let width = collectionView!.bounds.width
        return CGSize(width: width, height: 100000)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
