//
//  Double+Rounded.swift
//  VFGMVA10Foundation
//
//  Created by Erdem ILDIZ on 26.07.2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public extension Double {
    func roundedToDouble(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    func roundedToString(toPlaces places: Int) -> String {
        return String(format: "\(roundedToDouble(toPlaces: places))")
    }
}
