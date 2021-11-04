//
//  MVA10NavigationView.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 12/10/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

class MVA10NavigationView: UIView {
    @IBOutlet weak var bottomDivider: UIView!
    @IBOutlet weak var backButton: VFGButton!
    @IBOutlet weak var titleLabel: VFGLabel!
    @IBOutlet weak var closeButton: VFGButton!
    var hasDivider = true {
        didSet {
            self.bottomDivider.alpha = hasDivider ? 1: 0
        }
    }
    var isTransparentBackground = false {
        didSet {
            self.backgroundColor = isTransparentBackground ? .clear: .VFGWhiteBackground
        }
    }

    func setTitle(title: String, accessibilityIdentifier: String = "") {
        let attributes = [
            NSAttributedString.Key.font: UIFont.vodafoneRegular(19.0),
            .foregroundColor: UIColor.VFGPrimaryText
        ]
        let attrString = NSAttributedString(string: title, attributes: attributes)

        titleLabel.attributedText = attrString
        titleLabel.accessibilityIdentifier = accessibilityIdentifier
    }

    func setupColors(
        backgroundColor: UIColor,
        titleColor: UIColor,
        closeButtonColor: UIColor,
        backButtonColor: UIColor
    ) {
        self.backgroundColor = backgroundColor
        titleLabel.textColor = titleColor

        let closeButtonImage = VFGImage(named: "icClose")?.withRenderingMode(.alwaysTemplate)
        closeButton.setImage(closeButtonImage, for: .normal)
        closeButton.tintColor = closeButtonColor

        let backButtonImage = VFGImage(named: "icArrowLeft")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = backButtonColor
    }

    func setAccessibilityIDs(closeButtonID: String = "", backButtonID: String = "") {
        closeButton.accessibilityIdentifier = closeButtonID
        backButton.accessibilityIdentifier = backButtonID
    }
}
