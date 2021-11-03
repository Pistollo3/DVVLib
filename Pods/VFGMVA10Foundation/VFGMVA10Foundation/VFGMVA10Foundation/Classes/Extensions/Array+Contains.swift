//
//  Array+Contains.swift
//  VFGMVA10Foundation
//
//  Created by Erdem ILDIZ on 26.07.2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
