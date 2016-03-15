//
//  PickerTableViewController.swift
//  Picker
//
//  Created by Christian Otkjær on 10/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit

public class PickerTableViewController: UITableViewController, CellBasedPicker
{
    public typealias Item = NSObject
    
    public typealias Cell = UITableViewCell
    
    public var pickedItem: NSObject?
    
    public var items : [[NSObject]] = []
        { didSet { tableView?.reloadData() } }
    
    public var pickerDelegate: PickerDelegate?
}

// MARK: - CellBasedPicker

public extension PickerTableViewController
{
    public func cellForItem(item: Item, atIndexPath indexPath: NSIndexPath) -> Cell
    {
        return tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifierForItem(item, atIndexPath: indexPath), forIndexPath: indexPath)
    }
    
    func configureCell(cell: Cell, forItem item: Item, atIndexPath indexPath: NSIndexPath)
    {
        cell.accessoryType = pickedItem == item ? .Checkmark : .None

        cell.textLabel?.text = "\(item)"
    }
}

// MARK: - UITableViewDataSource

public extension PickerTableViewController
{
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return numberOfSections()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return numberOfItemsInSection(section) ?? 0
    }
    
    
    final override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        guard
            let item = itemForIndexPath(indexPath)
            else
        {
            fatalError("No item for indexPath: \(indexPath)")
        }
        
        let cellReuseIdentifier = cellReuseIdentifierForItem(item, atIndexPath: indexPath)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
        
        configureCell(cell, forItem: item, atIndexPath: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

public extension PickerTableViewController
{
    final override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    {
        guard let delegate = pickerDelegate else { return indexPath }
        
        if
            let item = itemForIndexPath(indexPath),
            let alternateItem = delegate.picker(self, willPick: item),
            let path = indexPathForItem(alternateItem)
        {
            return path
        }
        
        return nil
    }
    
    final override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var reloadIndexPaths = [indexPath]
        
        if let oldIndexPath = indexPathForItem(pickedItem)
        {
            reloadIndexPaths.append(oldIndexPath)
        }
        
        pickedItem = itemForIndexPath(indexPath)
        
        pickerDelegate?.picker(self, didPick: pickedItem)
        
        tableView.reloadRowsAtIndexPaths(reloadIndexPaths, withRowAnimation: .Automatic)
    }
}
