//
//  TransitionAnimator.swift
//  CollectionTransitions
//
//  Created by Nick on 1/7/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let reverse: Bool
    
    init(reverse: Bool) {
        self.reverse = reverse
        super.init()
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        let defaultTime = 0.32
        guard reverse else { return defaultTime }
        guard let transitionContext = transitionContext else { return defaultTime }
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? DetailViewController else { return defaultTime }
        guard let collectionView = fromVC.collectionView else { return defaultTime }
        
        let containFirstItem = collectionView.visibleCells().lazy.map { collectionView.indexPathForCell($0) }.contains { $0?.item == 0 }
        return containFirstItem ? defaultTime : 0.82
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else { return }
        guard let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else { return }
        guard let masterVC = (reverse ? toVC : fromVC) as? MasterViewController else { return }
        guard let detailVC = (reverse ? fromVC : toVC) as? DetailViewController else { return }
        guard let containerView = transitionContext.containerView() else { return }
        
        containerView.addSubview(toVC.view)
        if reverse {
            containerView.addSubview(fromVC.view)
        } else {
            toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
            toVC.view.layoutIfNeeded()
        }
        
        if !reverse {
            detailVC.collectionView?.backgroundColor = .clearColor()
        }
        
        let cell = masterVC.collectionView?.cellForItemAtIndexPath(masterVC.selectedIndex) as! MasterCell
        cell.colorViews.forEach { $0.alpha = 0 }
        detailVC.flowLayout.toStartPosition = reverse
        
        detailVC.collectionView?.performBatchUpdates({
            detailVC.collectionView?.collectionViewLayout.invalidateLayout()
        }, completion:nil)
        
        let invalidateTime = 0.32
        UIView.animateWithDuration(invalidateTime, animations: {
            detailVC.collectionView?.backgroundColor = self.reverse ? .clearColor() : masterVC.collectionView?.backgroundColor
        }) { _ in
            cell.colorViews.forEach { $0.alpha = 1 }
            UIView.animateWithDuration(self.transitionDuration(transitionContext) - invalidateTime, animations: {
                guard self.reverse else { return }
                fromVC.view.alpha = 0
            }) { _ in
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
}
