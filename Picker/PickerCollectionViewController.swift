//
//  PickerCollectionViewController.swift
//  Picker
//
//  Created by Christian Otkjær on 11/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Collections

public class PickerCollectionViewController: UICollectionViewController, Picker
{
    public typealias Item = NSObject
    
    public var pickedItem: NSObject?
    
    public var items : [[NSObject]] = []
        { didSet { collectionView?.reloadData() } }
    
    public var pickerDelegate: PickerDelegate?
}

// MARK: - Picker

public extension PickerCollectionViewController
{
    public func numberOfSections() -> Int
    {
        return items.count
    }
    
    public func numberOfItemsInSection(section: Int?) -> Int?
    {
        return items.get(section)?.count
    }
    
    public func itemForIndexPath(path: NSIndexPath?) -> Item?
    {
        return items.get(path?.section)?.get(path?.item)
    }
}

// MARK: - Defaults

public extension PickerCollectionViewController
{
    func cellReuseIdentifierForItem(item: Item, atIndexPath indexPath: NSIndexPath) -> String
    {
        return "Cell"
    }
    
    func configureCell(cell: UICollectionViewCell, forItem item: Item, atIndexPath indexPath: NSIndexPath)
    {
        debugPrint("override configureCell(cell: UICollectionViewCell, forItem item: Item, atIndexPath indexPath: NSIndexPath)")
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
        
        pickerDelegate?.picker(self, didPick: pickedItem)
        
        collectionView.reloadItemsAtIndexPaths(reloadIndexPaths)
    }
}
