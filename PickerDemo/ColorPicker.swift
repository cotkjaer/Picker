//
//  ColorPicker.swift
//  Picker
//
//  Created by Christian Otkjær on 11/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Picker

class ColorPicker: PickerCollectionViewController
{
    override func viewDidLoad()
    {
        items =
            [[
                UIColor(red: 0.4, green: 0.1, blue: 0.7, alpha: 1),
                UIColor(red: 0.3, green: 0.2, blue: 0.4, alpha: 1),
                UIColor(red: 0.8, green: 0.3, blue: 0.1, alpha: 1),
                UIColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 1),
                UIColor(red: 0.0, green: 0.5, blue: 0.9, alpha: 1)
            ]]
        
        super.viewDidLoad()
    }
    
    override func configureCell(cell: UICollectionViewCell, forItem item: Item, atIndexPath indexPath: NSIndexPath)
    {
        if let color = item as? UIColor
        {
            cell.backgroundColor = color
        }
    }
}
