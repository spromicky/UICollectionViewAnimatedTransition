//
//  DetailViewController.swift
//  CollectionTransitions
//
//  Created by Nick on 30/6/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit


class AnimateLayout: UICollectionViewFlowLayout {
    
    var frames: [CGRect]
    var toStartPosition = false
    
    init(frames: [CGRect]) {
        self.frames = frames
        super.init()
        
        itemSize = CGSize(width: 100, height: 100)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.frames = []
        super.init(coder: aDecoder)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElementsInRect(rect) else { return nil }
        
        if toStartPosition {
            for (index, frame) in frames.enumerate() {
                attributes[index].frame = frame
            }
        }
        
        return attributes
    }
}


class DetailViewController: UICollectionViewController {
    
    var flowLayout: AnimateLayout!
    var colorCollection: ColorCollection! {
        didSet {
            title = colorCollection.name
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.collectionViewLayout = flowLayout
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        flowLayout.toStartPosition = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        flowLayout.toStartPosition = true
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorCollection.colors.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("detail_cell", forIndexPath: indexPath)
        
        cell.backgroundColor = colorCollection.colors[indexPath.item]
        
        return cell
    }
}