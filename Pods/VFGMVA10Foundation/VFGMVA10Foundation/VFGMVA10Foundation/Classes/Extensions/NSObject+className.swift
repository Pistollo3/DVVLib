//
//  NSObject+className.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 11/26/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

extension NSObject {
    public var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last ?? ""
    }
}
