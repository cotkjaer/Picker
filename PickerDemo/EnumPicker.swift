//
//  EnumPicker.swift
//  Picker
//
//  Created by Christian Otkjær on 11/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Picker
import Collections

enum Shape
{
    case Circle, Ellipse, Triangle, Square
}

class EnumPicker: UITableViewController, Picker
{
    typealias Item = Shape
    
    var pickedItem : Shape?
    
    var pickerDelegate: PickerDelegate?
    
    let shapes: [[Shape]] =  [[.Circle, .Ellipse, .Triangle, .Square]]
    
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

extension EnumPicker: PickerDelegate
{
    func picker<P : Picker>(picker: P, didPick item: P.Item?)
    {
        debugPrint("picked \(item)")
    }
    
}

// MARK: - Picker

extension EnumPicker //: Picker
{
    func numberOfSections() -> Int
    {
        return shapes.count
    }
    
    func numberOfItemsInSection(section: Int?) -> Int?
    {
        return shapes.get(section)?.count
    }
    
    func itemForIndexPath(path: NSIndexPath?) -> Item?
    {
        return shapes.get(path?.section)?.get(path?.item)
    }
    
    func indexPathForItem(item: Item?) -> NSIndexPath?
    {
        guard let text = item else { return nil }
        
        for (section, items) in shapes.enumerate()
        {
            if let index = items.indexOf(text)
            {
                return NSIndexPath(forItem: index, inSection: section)
            }
        }
        
        return nil
    }
}

// MARK: - UITableViewDataSource

extension EnumPicker// : UITableViewDataSource
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
        
        cell.textLabel?.text = String(item)
        cell.accessoryType = item == pickedItem ? .Checkmark : .None
        
        let may = pickerDelegate?.picker(self, mayPick: item) == true
        let picked = item == pickedItem
        
        cell.textLabel?.alpha = may || picked ? 1 : 0.3
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension EnumPicker// : UITableViewDelegate
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


