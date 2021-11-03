//
//  VFGOverflowMenuItem.swift
//  VFGMVA10Foundation
//
//  Created by Fafoutis, Athinodoros, Vodafone Greece on 25/05/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public struct VFGOverflowMenuItem: Equatable {
    let primaryText: String
    let secondaryText: String?
    let leadingImage: UIImage?

    public init(
        primaryText: String,
        secondaryText: String? = nil,
        leadingImage: UIImage? = nil
    ) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.leadingImage = leadingImage
    }

    public static func == (lhs: VFGOverflowMenuItem, rhs: VFGOverflowMenuItem) -> Bool {
        return lhs.primaryText == rhs.primaryText &&
            lhs.secondaryText == rhs.secondaryText &&
            lhs.leadingImage == rhs.leadingImage
    }
}
