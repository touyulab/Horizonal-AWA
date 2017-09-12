//
//  MoodViewController.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/06.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class MoodViewController: UIViewController {
    
    // 遷移で使用
//    var selectedIndex: Int?
    var selectedMood: Mood?
    
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
        
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        navigationController?.delegate = self

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
        selectedMood = moodList[indexPath.item%12]
        let playlistVC = PlaylistsViewController.instantiate(withStoryboard: "Main")
        playlistVC.mood = moodList[indexPath.item%12]
//        playlistVC.transitioningDelegate = self
//        show(playlistVC, sender: self)
        navigationController?.pushViewController(playlistVC, animated: true)
    }
}

extension MoodViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animation(operation: operation)
    }
}

class Animation : NSObject, UIViewControllerAnimatedTransitioning {
    
    let operation: UINavigationControllerOperation
    
    private var blackLayer = CALayer()
    
    init(operation: UINavigationControllerOperation) {
        self.operation = operation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch operation {
        case .push:
            push(using: transitionContext)
        case .pop:
            pop(using: transitionContext)
        default:
            return
        }
    }
    
    private func push(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewCotnroller = transitionContext.viewController(forKey: .from) as? MoodViewController
        let toViewCotnroller = transitionContext.viewController(forKey: .to) as? PlaylistsViewController
        
        let containerView = transitionContext.containerView
        
        let fromView = fromViewCotnroller?.view
        let toView = toViewCotnroller?.view
        
        let cell = fromViewCotnroller!.collectionView.visibleCells
            .flatMap { $0 as? MoodCollectionViewCell }
            .filter { $0.mood == fromViewCotnroller!.selectedMood }
            .first
        
        let a = cell!.contentView.convert(cell!.moodImageScrollView.frame.origin, to: fromViewCotnroller!.collectionView)
        let b = fromViewCotnroller!.collectionView.convert(a, to: containerView)

        let copiedImageView = UIImageView(frame: CGRect(origin: b, size: cell!.moodImageScrollView.bounds.size))
        copiedImageView.image = cell?.moodImageView.image
        copiedImageView.contentMode = cell!.moodImageView.contentMode
        copiedImageView.layer.masksToBounds = true
        copiedImageView.layer.cornerRadius = copiedImageView.bounds.width/2
        blackLayer = makeBlackLayer(frame: copiedImageView.bounds)
        copiedImageView.layer.addSublayer(blackLayer)
        containerView.addSubview(copiedImageView)
        
        fromView?.frame = transitionContext.initialFrame(for: fromViewCotnroller!)
        toView?.frame = transitionContext.finalFrame(for: toViewCotnroller!)
        
        fromView?.alpha = 1.0
        toView?.alpha = 0.0
        cell?.moodImageView.alpha = 0
        
        containerView.addSubview(toView!)
        
        UIView.animate(withDuration: 0.4, animations: { [weak self] _ in
            copiedImageView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
            self?.blackLayer.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
            copiedImageView.layer.cornerRadius = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: { _ in
                fromView?.alpha = 0.0
                toView?.alpha = 1.0
            }, completion: { _ in
                copiedImageView.removeFromSuperview()
//                cell?.moodImageView.alpha = 1
                let wasCanceled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!wasCanceled)
            })
        })
    }
    
    private func pop(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewCotnroller = transitionContext.viewController(forKey: .from) as? PlaylistsViewController
        let toViewCotnroller = transitionContext.viewController(forKey: .to) as? MoodViewController
        
        let containerView = transitionContext.containerView
        
        let fromView = fromViewCotnroller?.view
        let toView = toViewCotnroller?.view
        
        fromView?.frame = transitionContext.initialFrame(for: fromViewCotnroller!)
        toView?.frame = transitionContext.finalFrame(for: toViewCotnroller!)
        
        fromView?.alpha = 1.0
        toView?.alpha = 0.0
        
        let copiedImageView = UIImageView(frame: fromViewCotnroller!.imageView.frame)
        copiedImageView.image = fromViewCotnroller!.imageView.image
        copiedImageView.contentMode = fromViewCotnroller!.imageView.contentMode
        copiedImageView.layer.masksToBounds = true
//        copiedImageView.layer.cornerRadius = copiedImageView.bounds.width/2
        blackLayer = makeBlackLayer(frame: copiedImageView.bounds)
        copiedImageView.layer.addSublayer(blackLayer)
        
        containerView.addSubview(toView!)
        
        containerView.addSubview(copiedImageView)
        
        let cell = toViewCotnroller!.collectionView.visibleCells
            .flatMap { $0 as? MoodCollectionViewCell }
            .filter { $0.mood == toViewCotnroller!.selectedMood }
            .first
        
        let a = cell!.contentView.convert(cell!.moodImageScrollView.frame.origin, to: toViewCotnroller!.collectionView)
        let b = toViewCotnroller!.collectionView.convert(a, to: containerView)
        
        UIView.animate(withDuration: 0.4, animations: { _ in
            copiedImageView.frame = CGRect(origin: b, size: cell!.moodImageScrollView.bounds.size)
            copiedImageView.layer.cornerRadius = cell!.moodImageScrollView.bounds.size.width/2
            copiedImageView.alpha = 0
            cell?.moodImageView.alpha = 1
            fromView?.alpha = 0.0
            toView?.alpha = 1.0
        }, completion: { _ in
            copiedImageView.removeFromSuperview()
//            cell?.moodImageView.alpha = 1
            let wasCanceled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCanceled)
        })
    }
    
    private func makeBlackLayer(frame: CGRect) -> CALayer {
        let blackLayer = CALayer()
        blackLayer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        blackLayer.frame = frame
        return blackLayer
    }
}
