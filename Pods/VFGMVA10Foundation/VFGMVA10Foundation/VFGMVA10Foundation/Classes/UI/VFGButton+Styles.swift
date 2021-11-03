//
//  VFGButton+Styles.swift
//  VFGMVA10Foundation
//
//  Created by Moustafa Hegazy on 04/08/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit

extension VFGButton {
    // MARK: - Primary
    func updatePrimaryLightBackgroundColor() {
        if isHighlighted {
            backgroundColor = .VFGPrimaryButtonActive
        } else if isEnabled {
            backgroundColor = .VFGPrimaryButton
        } else {
            backgroundColor = .VFGDisabledButton
        }
    }

    func updatePrimaryLightTextColor() {
        let textColor: UIColor
        if isHighlighted {
            textColor = .VFGPrimaryButtonActiveText
        } else if isEnabled {
            textColor = .VFGPrimaryButtonText
        } else {
            textColor = .VFGDisabledButtonText
        }
        setTitleColor(textColor, for: .normal)
    }

    // MARK: Primary Dark
    func updatePrimaryDarkBackgroundColor() {
        if isHighlighted {
            backgroundColor = .VFGPrimaryButtonActiveDarkBG
        } else if isEnabled {
            backgroundColor = .VFGPrimaryButtonDarkBG
        } else {
            backgroundColor = .VFGDisabledButtonDarkBG
        }
    }

    func updatePrimaryDarkTextColor() {
        let textColor: UIColor
        if isHighlighted {
            textColor = .VFGPrimaryButtonActiveTextDarkBG
        } else if isEnabled {
            textColor = .VFGPrimaryButtonTextDarkBG
        } else {
            textColor = .VFGDisabledButtonTextDarkBG
        }
        setTitleColor(textColor, for: .normal)
    }

    // MARK: Primary Red
    func updatePrimaryRedBackgroundColor() {
        if isHighlighted {
            backgroundColor = .VFGPrimaryButtonActiveRedBG
        } else if isEnabled {
            backgroundColor = .VFGPrimaryButtonRedBG
        } else {
            backgroundColor = .VFGDisabledButtonRedBG
        }
    }

    func updatePrimaryRedTextColor() {
        let textColor: UIColor
        if isHighlighted {
            textColor = .VFGPrimaryButtonActiveTextRedBG
        } else if isEnabled {
            textColor = .VFGPrimaryButtonTextRedBG
        } else {
            textColor = .VFGDisabledButtonText
        }
        setTitleColor(textColor, for: .normal)
    }

    // MARK: - Secondary
    func updateSecondaryLightBackgroundColor() {
        if isEnabled {
            layer.borderWidth = 1
            backgroundColor = .VFGSecondaryButton
            layer.borderColor = UIColor.VFGSecondaryButtonOutline.cgColor
            if isHighlighted {
                layer.borderColor = UIColor.VFGSecondaryButtonActiveOutline.cgColor
                backgroundColor = .VFGSecondaryButtonActive
            }
        } else {
            layer.borderWidth = 0
            backgroundColor = .VFGDisabledButton
        }
    }

    func updateSecondaryLightTextColor() {
        if isEnabled {
            setTitleColor(.VFGSecondaryButtonText, for: .normal)
        } else {
            setTitleColor(.VFGDisabledButtonText, for: .normal)
        }
    }

    // MARK: - Secondary Dark
    func updateSecondaryDarkBackgroundColor() {
        if isEnabled {
            layer.borderWidth = 1
            backgroundColor = .VFGSecondaryButtonDarkBG
            layer.borderColor = UIColor.VFGSecondaryButtonOutlineDarkBG.cgColor
            if isHighlighted {
                backgroundColor = .VFGSecondaryButtonActiveDarkBG
                layer.borderColor = UIColor.VFGSecondaryButtonActiveOutlineDarkBG.cgColor
            }
        } else {
            layer.borderWidth = 0
            backgroundColor = .VFGDisabledButtonDarkBG
        }
    }

    func updateSecondaryDarkTextColor() {
        setTitleColor(.VFGSecondaryButtonTextDarkBG, for: .normal)
        setTitleColor(.VFGSecondaryButtonActiveTextDarkBG, for: .highlighted)
        if !isEnabled {
            setTitleColor(.VFGDisabledButtonTextDarkBG, for: .normal)
        }
    }

    // MARK: - Secondary Red
    func updateSecondaryRedBackgroundColor() {
        if isEnabled {
            backgroundColor = .VFGSecondaryButtonRedBG
            if isHighlighted {
                backgroundColor = .VFGSecondaryButtonActiveRedBG
            }
        } else {
            backgroundColor = .VFGDisabledButtonRedBG
        }
    }

    func updateSecondaryRedTextColor() {
        setTitleColor(.VFGSecondaryButtonTextRedBG, for: .normal)
        setTitleColor(.VFGSecondaryButtonActiveTextRedBG, for: .highlighted)
        if !isEnabled {
            setTitleColor(.VFGDisabledButtonTextRedBG, for: .normal)
        }
    }

    // MARK: - Secondary Option 2
    func updateSecondaryOptionTwoBackgroundColor() {
        if isHighlighted {
            backgroundColor = .VFGSecondaryButtonActiveDarkBGTwo
        } else if isEnabled {
            backgroundColor = .VFGSecondaryButtonDarkBGTwo
        } else {
            backgroundColor = .VFGDisabledButtonDarkBG
        }
    }

    func updateSecondaryOptionTwoTextColor() {
        let textColor: UIColor
        if isHighlighted {
            textColor = .VFGSecondaryButtonActiveTextDarkBGTwo
        } else if isEnabled {
            textColor = .VFGSecondaryButtonTextDarkBGTwo
        } else {
            textColor = .VFGDisabledButtonTextDarkBG
        }
        setTitleColor(textColor, for: .normal)
    }

    // MARK: - Tertiary
    func updateTertiaryLightBackgroundColor() {
        if isHighlighted {
            backgroundColor = .VFGTertiaryButtonActive
        } else if isEnabled {
            backgroundColor = .VFGTertiaryButton
        } else {
            backgroundColor = .VFGDisabledButton
        }
    }

    func updateTertiaryLightTextColor() {
        let textColor: UIColor
        if isHighlighted {
            textColor = .VFGTertiaryButtonActiveText
        } else if isEnabled {
            textColor = .VFGTertiaryButtonText
        } else {
            textColor = .VFGDisabledButtonText
        }
        setTitleColor(textColor, for: .normal)
    }

    // MARK: - Tertiary Dark
    func updateTertiaryDarkBackgroundColor() {
        if isHighlighted {
            backgroundColor = .VFGTertiaryButtonActiveDarkBG
        } else if isEnabled {
            backgroundColor = .VFGTertiaryButtonDarkBG
        } else {
            backgroundColor = .VFGDisabledButtonDarkBG
        }
    }

    func updateTertiaryDarkTextColor() {
        let textColor: UIColor
        if isHighlighted {
            textColor = .VFGTertiaryButtonActiveTextDarkBG
        } else if isEnabled {
            textColor = .VFGTertiaryButtonTextDarkBG
        } else {
            textColor = .VFGDisabledButtonTextDarkBG
        }
        setTitleColor(textColor, for: .normal)
    }

    // MARK: - Icon
    func updateIconButtonStyle() {
        contentEdgeInsets = UIEdgeInsets.zero
    }
}
