//
//  VFGBadgeContentView.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 9/13/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public class VFGBadgeContentView: UIView {
    @IBOutlet weak var label: VFGLabel!
    @IBOutlet weak var imageView: VFGImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    let badgeContentWidth: CGFloat = 20.0
    let badgeTextContentWidth: CGFloat = 25

    @IBInspectable var color: UIColor? {
        didSet {
            label.backgroundColor = color ?? .clear
        }
    }

    @IBInspectable var textColor: UIColor? {
        didSet {
            label.textColor = textColor ?? .VFGWhiteText
        }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
    }

    /**
    - configuring badge label and color and its layout constraints

    - Parameter type: BadgeType enum.
    - Parameter icon: icon number as string value or it name from xcassets.
    - Parameter color: badge color.
    - Parameter text: badge model.
    - Parameter textColor: foreground text color.
    */
    func configure(with badgeModel: BadgeModel, completion: (() -> Void)? = nil) {
        switch badgeModel.type {
        case .text where badgeModel.text != nil:
            backgroundColor = badgeModel.backgroundColor
            label.backgroundColor = badgeModel.backgroundColor
            label.text = badgeModel.text
            label.textColor = badgeModel.textColor
            label.font = badgeModel.font
            label.isHidden = false
            imageView.isHidden = true
            var textWidth = badgeTextContentWidth +
                (label.text?.widthOfString(usingFont: label.font) ?? 0) // text width
            if Int(label.text ?? "") != nil {
                // numbers width
                textWidth = badgeContentWidth + getExtraWidth(badgeModel.text)
            }
            widthConstraint.constant = textWidth
            layoutIfNeeded()
        case .image where badgeModel.image != nil:
            imageView.image = badgeModel.image
            imageView.isHidden = false
            label.isHidden = true
        default:
            break
        }
        completion?()
        accessibilityValue = badgeModel.text
    }

    private func getNumberOfChars(_ text: String) -> Int {
        if text.count > 3 {
            return 3
        } else {
            return text.count
        }
    }

    private func getExtraWidth(_ text: String?) -> CGFloat {
        guard let text = text else {
            return 0
        }

        let numberOfChars = getNumberOfChars(text)
        if numberOfChars > 1 {
            return CGFloat(numberOfChars * numberOfChars)
        } else {
            return 0
        }
    }

    func reset() {
        imageView.image = nil
        imageView.isHidden = true
        label.isHidden = true
        widthConstraint.constant = badgeContentWidth
        layoutSubviews()
    }
}
