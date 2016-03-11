//
//  PickerDataSource.swift
//  Picker
//
//  Created by Christian Otkjær on 10/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//
/*
public protocol PickerDataSource
{
    /// return number of sections in picker
    func numberOfSectionsForPicker<P: Picker>(picker: P) -> Int
    
    /// return number of items in section
    func picker<P: Picker>(picker: P, numberOfItemsInSection: Int) -> Int
    
    /// return the item for a given indexPath
    func picker<P: Picker>(picker: P, itemForIndexPath: NSIndexPath) -> P.Item?
    
    /// return the path for a given item
    func picker<P : Picker>(picker: P, indexPathForItem item: P.Item?) -> NSIndexPath?
}

// MARK: - Defaults

public extension PickerDataSource
{
    func numberOfSectionsForPicker<P: Picker>(picker: P) -> Int
    {
        debugPrint("override numberOfSectionsForPicker<P: Picker>(picker: P) -> Int")
        return 0
    }
    
    func picker<P: Picker>(picker: P, numberOfItemsInSection section: Int) -> Int
    {
        debugPrint("override picker<P: Picker>(picker: P, numberOfItemsInSection: Int) -> Int")
        return 0
    }
    
    func picker<P: Picker>(picker: P, itemForIndexPath indexPath: NSIndexPath) -> P.Item?
    {
        debugPrint("override picker<P: Picker>(picker: P, itemForIndexPath: NSIndexPath) -> P.Item?")
        return nil
    }
}

public extension PickerDataSource where Self.Item: Equatable
{
    func picker<P : Picker>(picker: P, indexPathForItem item: P.Item?) -> NSIndexPath?
    {
        guard let item = item else { return nil }
        
        for sectionIndex in 0..<numberOfSectionsForPicker(picker)
        {
            for itemIndex in 0..<self.picker(picker, numberOfItemsInSection: sectionIndex)
            {
                let indexPath = NSIndexPath(forItem: itemIndex, inSection: sectionIndex)
                
                if self.picker(picker, itemForIndexPath: indexPath) == item
                {
                    return indexPath
                }
            }
        }
        
        return nil
    }
}
*/