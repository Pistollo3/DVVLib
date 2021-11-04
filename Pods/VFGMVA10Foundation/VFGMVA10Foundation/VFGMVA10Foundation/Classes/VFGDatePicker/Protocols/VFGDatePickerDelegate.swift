//
//  VFGDatePickerDelegate.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 14/09/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

public protocol VFGDatePickerDelegate: AnyObject {
    func datePicker(_ viewController: VFGDatePicker, dateDidSelect date: Date)
    func datePicker(_ viewController: VFGDatePicker, rangeDidSelect startDate: Date, _ endDate: Date)
}

public extension VFGDatePickerDelegate {
    func datePicker(_ viewController: VFGDatePicker, dateDidSelect date: Date) {}
    func datePicker(_ viewController: VFGDatePicker, rangeDidSelect startDate: Date, _ endDate: Date) {}
}
