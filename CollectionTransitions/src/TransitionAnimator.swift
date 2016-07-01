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
        return 0.32
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
        }, completion: { _ in
            cell.colorViews.forEach { $0.alpha = 1 }
        })
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(transitionDuration(transitionContext) * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            fromVC.view.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
        UIView.animateWithDuration(0.32) {
            detailVC.collectionView?.backgroundColor = self.reverse ? .clearColor() : masterVC.collectionView?.backgroundColor
        }
    }
}