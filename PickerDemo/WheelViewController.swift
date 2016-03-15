//
//  WheelViewController.swift
//  Picker
//
//  Created by Christian Otkjær on 15/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Picker

class WheelViewController: PickerViewController
{
    @IBOutlet weak var pickerView: UIPickerView?
        {
        didSet
        {
            updateWheel(false)
        }
    }

    override func viewDidLoad()
    {
        pickerDelegate = self

        items = [["1", "2", "3", "4"],["birds", "coconuts", "Quasits"]]

        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        updateWheel(false)
    }
    
    func updateWheel(animated: Bool) {
        pickerView?.reloadAllComponents()
    }
}

// MARK: - PickerDelegate

extension WheelViewController : PickerDelegate
{
    func picker<P : Picker>(picker: P, didPick item: P.Item?)
    {
        debugPrint("\(item)")
    }
}

