//
//  NavigationDelegate.swift
//  CollectionTransitions
//
//  Created by Nick on 1/7/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

class NavigationDelegate: NSObject, UINavigationControllerDelegate {

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return TransitionAnimator(reverse: operation == .Pop)
    }
}