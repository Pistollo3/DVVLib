//
//  Array+AppendIfNotNil.swift
//  VFGMVA10Billing
//
//  Created by Mohamed Abd ElNasser on 5/18/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

extension Array {
    public mutating func appendIfNotNil(_ newElement: Element?) {
        if let element = newElement {
            append(element)
        }
    }
}
