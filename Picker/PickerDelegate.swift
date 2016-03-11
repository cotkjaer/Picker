//
//  PickerDelegate.swift
//  Picker
//
//  Created by Christian Otkjær on 10/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

public protocol PickerDelegate
{
    /**
     Tells the delegate that a specified item was picked.
     */
    func picker<P: Picker>(picker: P, didPick item: P.Item?)
    
    /**
     Asks the delegate to confirm the imminent picking of the specified item.
     
     Return an item that confirms or alters the pick;
       - Return an alternate item if you want that item to be picked instead
       - Return `nil` if you do not want the item picked (the currently picked item remains picked).
     */
    func picker<P: Picker>(picker: P, willPick item: P.Item?) -> P.Item?
    
    /**
     Asks the delegate whether the specified item is pickable
     
     Return `true` if the item should be pickable, `false` if not. 
     
     defaults to `true`
     */
    func picker<P: Picker>(picker: P, mayPick item: P.Item?) -> Bool
}

// MARK: - Default

public extension PickerDelegate
{
    func picker<P: Picker>(picker: P, didPick item: P.Item?)
    {
        debugPrint("picker \(picker) didPick: \(item)")
    }
    
    func picker<P: Picker>(picker: P, willPick item: P.Item?) -> P.Item?
    {
        debugPrint("picker \(picker) willPick: \(item)")
        return item
    }
    
    func picker<P: Picker>(picker: P, mayPick item: P.Item?) -> Bool
    {
        debugPrint("picker \(picker) mayPick: \(item)")
        return true
    }
}
