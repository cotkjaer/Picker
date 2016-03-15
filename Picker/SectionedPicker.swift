//
//  CellBasedPicker.swift
//  Picker
//
//  Created by Christian Otkjær on 15/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

// MARK: - CellBasedPicker

public protocol CellBasedPicker : Picker
{
    typealias Cell
    
    
    func cellReuseIdentifierForItem(item: Item, atIndexPath indexPath: NSIndexPath) -> String
    
    func cellForItem(item: Item, atIndexPath indexPath: NSIndexPath) -> Cell
    
    func configureCell(cell: Cell, forItem item: Item, atIndexPath indexPath: NSIndexPath)
}

// MARK: - Defaults

public extension CellBasedPicker
{
    func numberOfSections() -> Int
    {
        return items.count
    }
    
    func numberOfItemsInSection(section: Int?) -> Int?
    {
        return items.get(section)?.count
    }
    
    func itemForIndexPath(path: NSIndexPath?) -> Item?
    {
        return items.get(path?.section)?.get(path?.item)
    }
    
    func cellReuseIdentifierForItem(item: Item, atIndexPath indexPath: NSIndexPath) -> String
    {
        return "Cell"
    }
}
