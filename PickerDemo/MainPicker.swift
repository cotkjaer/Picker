//
//  MainPicker.swift
//  Picker
//
//  Created by Christian Otkjær on 11/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Picker

class MainPicker: PickerTableViewController
{
    @IBOutlet weak var anchorView: UIView!
    
    override func viewDidLoad()
    {
        pickerDelegate = self
                
        items = [["Text", "Mixed", "Enum"], ["Color"], ["Wheel"]]
        
        super.viewDidLoad()
    }
    
    override func configureCell(cell: UITableViewCell, forItem item: Item, atIndexPath indexPath: NSIndexPath)
    {
        super.configureCell(cell, forItem: item, atIndexPath: indexPath)
        
        cell.detailTextLabel?.text = String(item.dynamicType)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section
        {
        case 0:
            return "Table"
        case 1:
            return "Collection"
        case 2:
            return "Wheel"
        default:
            return nil
        }
    }
}

// MARK: - PickerDelegate

extension MainPicker : PickerDelegate
{
    func picker<P : Picker>(picker: P, didPick item: P.Item?)
    {
            if let text = item as? String
            {
                performSegueWithIdentifier(text, sender: nil)
            }
        
        if let color = item as? UIColor
        {
            view.tintColor = color
            navigationController?.view.tintColor = color
        }
    }
}

// MARK: - Navigation

extension MainPicker
{
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let cell = sender as? UITableViewCell
        {
            anchorView.frame = tableView.convertRect(cell.bounds, fromView: cell)
        }
        
        if let picker = segue.destinationViewController as? PickerCollectionViewController
        {
            picker.pickerDelegate = self
        }
    }
}


