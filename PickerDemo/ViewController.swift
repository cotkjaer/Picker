//
//  ViewController.swift
//  PickerDemo
//
//  Created by Christian Otkjær on 10/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Picker
import Collections

class ViewController: UITableViewController, Picker
{
    typealias Item = String
    
    var pickedItem : String?
    
    var pickerDelegate: PickerDelegate?
    
    let items = [["one", "two"], ["camel", "alpha", "Congo", "88 (crazy)"], ["Lorem ipsum"], [], ["5th", "bare bones"]]
    
    override func viewDidLoad()
    {
        pickerDelegate = self
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        reloadItems()
    }
    
    func reloadItems(onlyVisible: Bool = true)
    {
        tableView.reloadData()
    }
}

// MARK: - PickerDelegate

extension ViewController: PickerDelegate
{
    func picker<P : Picker>(picker: P, willPick item: P.Item?) -> P.Item?
    {
        return self.picker(picker, mayPick: item) == true ? item : nil
    }
    
    func picker<P : Picker>(picker: P, mayPick item: P.Item?) -> Bool
    {
        guard let picker = picker as? ViewController else { return false }
        
        guard picker == self else { return false }

        guard let string = item as? String else { return false }
        
        return string != pickedItem && string.characters.count > 5
    }
}

// MARK: - Picker

extension ViewController //: Picker
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
    
    func indexPathForItem(item: Item?) -> NSIndexPath?
    {
        guard let text = item else { return nil }
        
        for (section, texts) in items.enumerate()
        {
            if let index = texts.indexOf(text)
            {
                return NSIndexPath(forItem: index, inSection: section)
            }
        }

        return nil
    }
}

// MARK: - UITableViewDataSource

extension ViewController// : UITableViewDataSource
{
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return numberOfSections()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return numberOfItemsInSection(section) ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let item = itemForIndexPath(indexPath)
        
        cell.textLabel?.text = item
        cell.accessoryType = item == pickedItem ? .Checkmark : .None

        let may = pickerDelegate?.picker(self, mayPick: item) == true
        let picked = item == pickedItem
        
        cell.textLabel?.alpha = may || picked ? 1 : 0.3
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return String(section + 1)
    }
}

// MARK: - UITableViewDelegate

extension ViewController// : UITableViewDelegate
{
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    {
        if
            let item = itemForIndexPath(indexPath),
            let alternateItem = pickerDelegate?.picker(self, willPick: item),
            let path = indexPathForItem(alternateItem)
        {
            return path
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
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


