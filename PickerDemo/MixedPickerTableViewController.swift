//
//  ColorPickerTableViewController.swift
//  Picker
//
//  Created by Christian Otkjær on 10/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Picker

class MixedPicker: PickerTableViewController
{
    override func viewDidLoad()
    {
        items = [[0.5, UIColor(red: 0.4, green: 0.1, blue: 0.7, alpha: 1)], ["Banana", 1]]
        
        super.viewDidLoad()
    }
    
    override func configureCell(cell: UITableViewCell, forItem item: Item, atIndexPath indexPath: NSIndexPath)
    {
        super.configureCell(cell, forItem: item, atIndexPath: indexPath)
        
        cell.detailTextLabel?.text = String(item.dynamicType)
        
        if let color = item as? UIColor
        {
            cell.textLabel?.textColor = color
        }
        else
        {
            cell.textLabel?.textColor = UIColor.darkTextColor()
        }
        
        
        
    }
}
