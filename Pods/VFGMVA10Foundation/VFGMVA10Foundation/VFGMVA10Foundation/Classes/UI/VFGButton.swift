//
//  VFGButton.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 6/30/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

/// Designable and inspectable UIButton that allows customisations of font, size, style and background. **VFGButton** contains five button styles which vary depending on the background.
@IBDesignable
public class VFGButton: UIButton {
    // MARK: - initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @objc public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        isEnabled = true
        layer.cornerRadius = 6
        setTitleColor(titleColor, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    // MARK: - local properties
    var type: ButtonStyle = .customStyle
    var backgroundType: BackgroundStyle = .light

    // MARK: - inspectable(s)
    @IBInspectable var imageName: String = "" {
        didSet {
            setImage(VFGImage(named: imageName), for: state)
            if UIView.appearance().semanticContentAttribute == .forceRightToLeft, buttonStyle == 5 {
                transform = CGAffineTransform(scaleX: -1, y: 1)
            }
        }
    }
    /// Button text title color
    @IBInspectable var titleColor: UIColor? {
        get {
            return self.titleColor(for: .normal)
        }
        set {
            if let color = newValue {
                setTitleColor(color, for: .normal)
            } else {
                setTitleColor(.white, for: .normal)
            }
        }
    }

    /// Represent `ButtonStyle` enum and it has 6 value from 0 to 5
    /// - 0 : primary style
    /// - 1 : secondary style
    /// - 2 : secondary option 2 style
    /// - 3 : tertiary style
    /// - 4 : custom style
    /// - 5 : icon style
    @IBInspectable public var buttonStyle: Int {
        get {
            return type.rawValue
        }
        set(buttonType) {
            type = ButtonStyle(rawValue: buttonType) ?? .customStyle
            editButtonStyle()
        }
    }

    /// Represent `BackgroundStyle` enum and it has 3 value from 0 to 2
    /// - 0 : light backgrounds
    /// - 1 : dark backgrounds
    /// - 2 : red backgrounds
    @IBInspectable public var backgroundStyle: Int {
        get {
            return backgroundType.rawValue
        }
        set (type) {
            backgroundType = BackgroundStyle(rawValue: type) ?? .light
            editButtonStyle()
        }
    }

    // MARK: - overrides
    // The background color when button enabled
    public override var isEnabled: Bool {
        didSet {
            let color = isEnabled ? enabledColor : disabledColor
            guard let buttonColor = color else {
                editButtonStyle()
                return
            }
            layer.borderWidth = 0
            backgroundColor = buttonColor
        }
    }
    /// `isHighlighted` status change button appearance depends on it's style and background
    public override var isHighlighted: Bool {
        didSet {
            editButtonStyle()
        }
    }

    // MARK: - public properties
    /// The button style
    public enum ButtonStyle: Int {
        case primary
        case secondary
        case secondaryOptionTwo
        case tertiary
        case customStyle
        /// icon button
        case icon
    }

    // Background mode
    public enum BackgroundStyle: Int {
        /// The light backgrounds
        case light
        /// The dark backgrounds
        case dark
        /// The red backgrounds
        case red
    }

    /// The background color when button enabled
    public var enabledColor: UIColor? {
        willSet {
            if isEnabled == true {
                backgroundColor = newValue
            }
        }
    }

    /// The background color when button disabled
    public var disabledColor: UIColor? {
        willSet {
            if isEnabled == false {
                backgroundColor = newValue
            }
        }
    }

    // MARK: - private methods
    private func editButtonStyle() {
        switch backgroundType {
        case .light:
            lightStyle()
        case .dark:
            darkStyle()
        case .red:
            redStyle()
        }
    }

    private func lightStyle() {
        switch type {
        case .primary:
            updatePrimaryLightBackgroundColor()
            updatePrimaryLightTextColor()
        case .secondary:
            updateSecondaryLightBackgroundColor()
            updateSecondaryLightTextColor()
        case .secondaryOptionTwo:
            break
        case .tertiary:
            updateTertiaryLightTextColor()
            updateTertiaryLightBackgroundColor()
        case .icon:
            updateIconButtonStyle()
        case .customStyle:
            break
        }
    }

    private func darkStyle() {
        switch type {
        case .primary:
            updatePrimaryDarkBackgroundColor()
            updatePrimaryDarkTextColor()
        case .secondary:
            updateSecondaryDarkBackgroundColor()
            updateSecondaryDarkTextColor()
        case .secondaryOptionTwo:
            updateSecondaryOptionTwoBackgroundColor()
            updateSecondaryOptionTwoTextColor()
        case .tertiary:
            updateTertiaryDarkBackgroundColor()
            updateTertiaryDarkTextColor()
        case .icon:
            updateIconButtonStyle()
        case .customStyle:
            break
        }
    }

    private func redStyle() {
        switch type {
        case .primary:
            updatePrimaryRedBackgroundColor()
            updatePrimaryRedTextColor()
        case .secondary:
            updateSecondaryRedBackgroundColor()
            updateSecondaryRedTextColor()
        case .secondaryOptionTwo:
            break
        case .tertiary:
            break
        case .icon:
            updateIconButtonStyle()
        case .customStyle:
            break
        }
    }
}
