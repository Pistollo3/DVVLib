//
//  VFGPageBannerModel.swift
//  VFGMVA10Foundation
//
//  Created by Hamsa Hassan on 9/1/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public struct VFGPageBannerModel {
    var header: String
    var headerTextColor: UIColor
    var description: String
    var descriptionTextColor: UIColor
    var image: UIImage?
    var primaryButton: String
    var primaryButtonBackgroundColor: UIColor
    var primaryButtonBorderColor: UIColor
    var primaryButtonTitleColor: UIColor
    var secondaryButton: String
    var secondaryButtonBackgroundColor: UIColor
    var secondaryButtonBorderColor: UIColor
    var secondaryButtonTitleColor: UIColor
    var backgroundColors: [CGColor]
    var buttonType: ButtonType

    public enum ButtonType {
        case none
        case toggle(isOn: Bool)
        case close
    }

    public init(
        header: String,
        headerTextColor: UIColor = .VFGWhiteText,
        description: String,
        descriptionTextColor: UIColor = .VFGWhiteText,
        image: UIImage? = nil,
        primaryButton: String,
        primaryButtonBackgroundColor: UIColor = .clear,
        primaryButtonBorderColor: UIColor = .VFGSecondaryButtonActiveOutlineDarkBG,
        primaryButtonTitleColor: UIColor = .VFGSecondaryButtonActiveTextDarkBG,
        secondaryButton: String,
        secondaryButtonBackgroundColor: UIColor = .clear,
        secondaryButtonBorderColor: UIColor = .VFGSecondaryButtonActiveOutlineDarkBG,
        secondaryButtonTitleColor: UIColor = .VFGSecondaryButtonActiveTextDarkBG,
        backgroundColors: [CGColor] = UIColor.VFGDiscoverRedGradient,
        buttonType: ButtonType = .none
    ) {
        self.header = header
        self.headerTextColor = headerTextColor
        self.description = description
        self.descriptionTextColor = descriptionTextColor
        self.image = image
        self.primaryButton = primaryButton
        self.primaryButtonBackgroundColor = primaryButtonBackgroundColor
        self.primaryButtonBorderColor = primaryButtonBorderColor
        self.primaryButtonTitleColor = primaryButtonTitleColor
        self.secondaryButton = secondaryButton
        self.secondaryButtonBackgroundColor = secondaryButtonBackgroundColor
        self.secondaryButtonBorderColor = secondaryButtonBorderColor
        self.secondaryButtonTitleColor = secondaryButtonTitleColor
        self.backgroundColors = backgroundColors
        self.buttonType = buttonType
    }
}
