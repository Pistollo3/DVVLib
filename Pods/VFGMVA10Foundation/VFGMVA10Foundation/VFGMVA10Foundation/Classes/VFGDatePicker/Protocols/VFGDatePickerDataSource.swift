//
//  VFGDatePickerDataSource.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 21/09/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//


public protocol VFGDatePickerDataSource: AnyObject {
    func dayOfWeekLetter(for dayNumber: Int) -> String
}
