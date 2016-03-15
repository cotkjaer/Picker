//
//  PickerViewController.swift
//  Picker
//
//  Created by Christian Otkjær on 15/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit

public class PickerViewController: UIViewController, CellBasedPicker
{
    var pickerView : UIPickerView?
        {
        didSet
        {
            pickerView?.delegate = self
            pickerView?.dataSource = self
        }
    }
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        preferredContentSize = CGSize(width: 320, height: 216)
    }
    
    public typealias Item = NSObject
    
    public typealias Cell = UILabel
    
    public var pickedItem: NSObject?
    
    public var items : [[NSObject]] = []
        { didSet { pickerView?.setNeedsDisplay() } }
    
    public var pickerDelegate: PickerDelegate?
}

// MARK: - CellBasedPicker

extension PickerViewController
{
    
    public func cellForItem(item: Item, atIndexPath indexPath: NSIndexPath) -> Cell
    {
        return UILabel()
    }
    
    public func configureCell(cell: Cell, forItem item: Item, atIndexPath indexPath: NSIndexPath)
    {
        cell.text = String(item)
    }
}


// MARK: - UIPickerViewDataSource

extension PickerViewController : UIPickerViewDataSource
{
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return numberOfSections()
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return numberOfItemsInSection(component) ?? 0
    }
}


// MARK: - UIPickerViewDelegate

extension PickerViewController : UIPickerViewDelegate
{
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        guard let item = itemForIndexPath(NSIndexPath(forItem: row, inSection: component))
            else
        {
            fatalError("No item at \(row) x \(component)")
        }
        
        pickerDelegate?.picker(self, didPick: item)
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        guard let item = itemForIndexPath(NSIndexPath(forItem: row, inSection: component))
            else
        {
            fatalError("No item at \(row) x \(component)")
        }
        
        return String(item)
    }
    
    public func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView
    {
        let indexPath = NSIndexPath(forItem: row, inSection: component)
        
        guard let item = itemForIndexPath(indexPath)
            else
        {
            fatalError("No item at \(row) x \(component)")
        }
        
        let cell = view as? Cell ?? cellForItem(item, atIndexPath: indexPath)
        
        configureCell(cell, forItem: item, atIndexPath: indexPath)
        
        return cell
    }
}

