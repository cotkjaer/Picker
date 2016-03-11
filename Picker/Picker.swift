//
//  Picker.swift
//  Picker
//
//  Created by Christian Otkjær on 27/01/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Foundation

public protocol Picker
{
    typealias Item : Equatable
    
    var pickedItem: Item? { get set }
    
//    var items : [[Item]] { get }
    
    var pickerDelegate : PickerDelegate? { get set }
    
    /// return number of sections in picker
    func numberOfSections() -> Int
    
    /// return number of items in section
    func numberOfItemsInSection(section: Int?) -> Int?
    
    /// return the item for a given index-path
    func itemForIndexPath(path: NSIndexPath?) -> Item?
    
    /// return the path for a given item
    func indexPathForItem(item: Item?) -> NSIndexPath?
}

// MARK: - Defaults

public extension Picker
{
    func numberOfSections() -> Int
    {
        debugPrint("override numberOfSectionsForPicker<P: Picker>(picker: P) -> Int")
        return 0
    }
    /// return number of items in section
    func numberOfItemsInSection(section: Int?) -> Int?
    {
        debugPrint("override numberOfItemsInSection(section: Int?) -> Int?")
        return 0
    }
    /// return the item for a given index-path
    func itemForIndexPath(path: NSIndexPath?) -> Item?
    {
        debugPrint("override itemForIndexPath(path: NSIndexPath?) -> Item?")
        return nil
    }

    /// return the path for a given item
    func indexPathForItem(item: Item?) -> NSIndexPath?
    {
        guard let item = item else { return nil }
        
        for sectionIndex in 0..<numberOfSections()
        {
            for itemIndex in 0..<(numberOfItemsInSection( sectionIndex) ?? 0)
            {
                let indexPath = NSIndexPath(forItem: itemIndex, inSection: sectionIndex)
                
                if itemForIndexPath(indexPath) == item
                {
                    return indexPath
                }
            }
        }
        
        return nil
    }
}

