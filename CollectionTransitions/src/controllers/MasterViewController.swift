//
//  MasterViewController.swift
//  CollectionTransitions
//
//  Created by Nick on 30/6/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit


class MasterCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var colorViews: [UIView]!
    
    func update(colorCollection collection: ColorCollection) {
        titleLabel.text = collection.name
        
        colorViews.forEach { $0.backgroundColor = .clearColor() }
        
        for (index, colorView) in colorViews.enumerate() {
            guard index < collection.colors.count else { continue }
            colorView.backgroundColor = collection.colors[index]
        }
    }
}


class MasterViewController: UICollectionViewController {
    
    var selectedIndex: NSIndexPath!
    private let colorCollection = ColorCollection.sharedCollection
    private let navigationDelegate = NavigationDelegate()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        navigationController?.delegate = navigationDelegate
        guard let detailVC = segue.destinationViewController as? DetailViewController else { return }
        
        let cell   = collectionView?.cellForItemAtIndexPath(selectedIndex) as! MasterCell
        let frames = cell.colorViews.map { cell.convertRect($0.frame, toView: collectionView) }
        let layout = AnimateLayout(frames: frames)
        
        detailVC.flowLayout      = layout
        detailVC.colorCollection = colorCollection[selectedIndex.item]
    }
    
    //MARK: - Collection View
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorCollection.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCellWithReuseIdentifier("master_cell", forIndexPath: indexPath) as! MasterCell
        
        cell.update(colorCollection: colorCollection[indexPath.item])
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath
        performSegueWithIdentifier("detail_segue", sender: nil)
    }
}
