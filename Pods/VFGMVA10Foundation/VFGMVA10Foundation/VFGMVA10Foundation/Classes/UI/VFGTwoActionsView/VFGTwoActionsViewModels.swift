//
//  VFGTwoActionsViewModels.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 7/1/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public struct VFGTitlesModel {
    public let title: String?
    public let description: String?
    public let descriptionAttributedString: NSMutableAttributedString?
    public let moreDetails: String?
    public let primaryButtonTitle: String?
    public let secondaryButtonTitle: String?

    public init(
        title: String? = nil,
        description: String? = nil,
        descriptionAttributedString: NSMutableAttributedString? = nil,
        moreDetails: String? = nil,
        primaryButtonTitle: String? = nil,
        secondaryButtonTitle: String? = nil
    ) {
        self.title = title
        self.description = description
        self.descriptionAttributedString = descriptionAttributedString
        self.moreDetails = moreDetails
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
    }
}

public struct VFGTitlesFontModel {
    public let titleFont: UIFont
    public let descriptionFont: UIFont
    public let moreDetailsFont: UIFont

    public init(
        titleFont: UIFont = .vodafoneRegular(16),
        descriptionFont: UIFont = .vodafoneRegular(16),
        moreDetailsFont: UIFont = .vodafoneRegular(16)
    ) {
        self.titleFont = titleFont
        self.descriptionFont = descriptionFont
        self.moreDetailsFont = moreDetailsFont
    }
}

public struct VFGTitlesAlignmentModel {
    public let titleAlignment: NSTextAlignment
    public let descriptionAlignment: NSTextAlignment
    public let moreDetailsAlignment: NSTextAlignment

    public init(
        titleAlignment: NSTextAlignment = .natural,
        descriptionAlignment: NSTextAlignment = .natural,
        moreDetailsAlignment: NSTextAlignment = .natural
    ) {
        self.titleAlignment = titleAlignment
        self.descriptionAlignment = descriptionAlignment
        self.moreDetailsAlignment = moreDetailsAlignment
    }
}

public struct VFGTwoActionsAccessibilityModel {
    public let icon: String
    public let title: String
    public let description: String
    public let moreDetails: String
    public let primaryButton: String
    public let secondaryButton: String

    public init(
        icon: String = "",
        title: String = "",
        description: String = "",
        moreDetails: String = "",
        primaryButton: String = "",
        secondaryButton: String = ""
    ) {
        self.icon = icon
        self.title = title
        self.description = description
        self.moreDetails = moreDetails
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }
}
