//
//  PickerCollectionViewController.swift
//  Picker
//
//  Created by Christian Otkjær on 11/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Collections

public class PickerCollectionViewController: UICollectionViewController, CellBasedPicker
{
    public typealias Item = NSObject
    
    public typealias Cell = UICollectionViewCell
    
    public var pickedItem: NSObject?
    
    public var items : [[NSObject]] = []
        { didSet { collectionView?.reloadData() } }
    
    public var pickerDelegate: PickerDelegate?
}

// MARK: - Defaults

public extension PickerCollectionViewController
{
    public func cellForItem(item: Item, atIndexPath indexPath: NSIndexPath) -> Cell
    {
        return collectionView!.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifierForItem(item, atIndexPath: indexPath), forIndexPath: indexPath)
    }
    
    func configureCell(cell: UICollectionViewCell, forItem item: Item, atIndexPath indexPath: NSIndexPath)
    {
        fatalError("override configureCell(cell: UICollectionViewCell, forItem item: Item, atIndexPath indexPath: NSIndexPath)")
    }
}

// MARK: - UICollectionViewDataSource

public extension PickerCollectionViewController
{
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return numberOfSections()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return numberOfItemsInSection(section) ?? 0
    }
    
    final override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        guard
            let item = itemForIndexPath(indexPath)
            else
        {
            fatalError("No item for indexPath: \(indexPath)")
        }
        
        let cellReuseIdentifier = cellReuseIdentifierForItem(item, atIndexPath: indexPath)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
        
        configureCell(cell, forItem: item, atIndexPath: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

public extension PickerCollectionViewController
{
    final override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        guard let delegate = pickerDelegate else { return true }
        
        if
            let item = itemForIndexPath(indexPath),
            let alternateItem = delegate.picker(self, willPick: item)
        {
            return alternateItem == item
        }
        
        return false
    }
    
    final override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        var reloadIndexPaths = [indexPath]
        
        if let oldIndexPath = indexPathForItem(pickedItem)
        {
            reloadIndexPaths.append(oldIndexPath)
        }
        
        pickedItem = itemForIndexPath(indexPath)
        
        
        collectionView.performBatchUpdates({

            collectionView.reloadItemsAtIndexPaths(reloadIndexPaths)

            }) { (completed) -> Void in

                self.pickerDelegate?.picker(self, didPick: self.pickedItem)
        }
        
    }
}
