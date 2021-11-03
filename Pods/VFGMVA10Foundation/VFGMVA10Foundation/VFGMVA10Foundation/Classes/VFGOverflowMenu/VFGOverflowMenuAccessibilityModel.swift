//
//  VFGOverflowMenuAccessibilityModel.swift
//  VFGMVA10Foundation
//
//  Created by Fafoutis, Athinodoros, Vodafone Greece on 01/06/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public struct VFGOverflowMenuAccessibilityModel {
    public let leadingImage: String
    public let primaryText: String
    public let secondaryText: String

    public init(
        leadingImage: String = "",
        primaryText: String = "",
        secondaryText: String = ""
    ) {
        self.leadingImage = leadingImage
        self.primaryText = primaryText
        self.secondaryText = secondaryText
    }
}
