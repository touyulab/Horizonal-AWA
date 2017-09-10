//
//  PlaylistsCollectionViewCell.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class PlaylistsCollectionViewCell: UICollectionViewCell {
    var titleLabel = UILabel()
    var commentTextView = UITextView()
    var smallJacketImageView1 = UIImageView()
    var smallJacketImageView2 = UIImageView()
    var bigJacketImageView = UIImageView()
    
    var cyberLine = CyberLine()
    
    var playlist = Playlist() {
        didSet {
            contentView.subviews.forEach { $0.removeFromSuperview() }
            
            // 順番に注意
            initJackets()
            initBezierLine()
            initTitleLabel()
            initCommentLabel()
        }
    }
    
    func set(playlist: Playlist) {
        self.playlist = playlist
    }
    
    private func initJackets() {
        let smallJacketSize = CGSize(width: 66, height: 66)
        smallJacketImageView2.frame = CGRect(origin: CGPoint(x: contentView.bounds.width - smallJacketSize.width,
                                                            y: contentView.bounds.height - smallJacketSize.height),
                                            size: smallJacketSize)
        smallJacketImageView2.image = #imageLiteral(resourceName: "happy")
        contentView.addSubview(smallJacketImageView2)
        
        smallJacketImageView1.frame = CGRect(origin: CGPoint(x: smallJacketImageView2.frame.origin.x,
                                                             y: smallJacketImageView2.frame.origin.y - smallJacketSize.height),
                                             size: smallJacketSize)
        smallJacketImageView1.image = #imageLiteral(resourceName: "drive")
        contentView.addSubview(smallJacketImageView1)
        
        let bigJacketSize = CGSize(width: smallJacketSize.width*2, height: smallJacketSize.height*2)
        bigJacketImageView.frame = CGRect(origin: CGPoint(x: smallJacketImageView1.frame.origin.x - bigJacketSize.width,
                                                          y: smallJacketImageView1.frame.origin.y),
                                          size: bigJacketSize)
        bigJacketImageView.image = #imageLiteral(resourceName: "love")
        contentView.addSubview(bigJacketImageView)
        
    }
    
    private func initBezierLine() {
        let angle = radian(degree: 45)
        let width = titleLabelWidth()+24*sin(angle)
        let height = 24*sin(angle)
        let size = CGSize(width: width,
                          height: height)
        let x = bigJacketImageView.frame.origin.x - width
        let y = bigJacketImageView.frame.origin.y - height
        let origin = CGPoint(x: x, y: y)
        cyberLine = CyberLine(frame: CGRect(origin: origin,
                                            size: size))
        contentView.addSubview(cyberLine)
    }
    
    private func initTitleLabel() {
        titleLabel = makeTitleLabel()
        contentView.addSubview(titleLabel)
    }
    
    private func titleLabelWidth() -> CGFloat {
        return makeTitleLabel().bounds.width
    }
    
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: cyberLine.frame.origin.x, y: 0),
                                               size: .zero))
        titleLabel.text = playlist.title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        titleLabel.frame.origin.y = cyberLine.frame.origin.y - titleLabel.bounds.height
        return titleLabel
    }
    
    private func makeCommentLabel() -> UITextView {
        let commentTextView = UITextView(frame: CGRect(origin: CGPoint(x: cyberLine.frame.origin.x,
                                                                       y: 0),
                                                       size: CGSize(width: titleLabel.bounds.width+16,
                                                                    height: bounds.height)))
        commentTextView.text = playlist.comment
        commentTextView.font = UIFont.systemFont(ofSize: 14)
        commentTextView.textColor = .white
        commentTextView.frame.origin.x = cyberLine.frame.origin.x - 6
        commentTextView.frame.origin.y = cyberLine.frame.origin.y - 4
        commentTextView.backgroundColor = UIColor.white.withAlphaComponent(0)
        return commentTextView
    }
    
    private func initCommentLabel() {
        commentTextView = makeCommentLabel()
        contentView.addSubview(commentTextView)
    }
}
