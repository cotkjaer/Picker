//
//  CNContactPickerViewController.swift
//  Picker
//
//  Created by Christian Otkjær on 04/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import ContactsUI

// MARK: - CNContactPickerViewController

@available(iOS 9.0, *)
extension CNContactPickerViewController
{
    @available(iOS 9.0, *)
    public convenience init(delegate: CNContactPickerDelegate)
    {
        self.init()
        self.delegate = delegate
    }
}