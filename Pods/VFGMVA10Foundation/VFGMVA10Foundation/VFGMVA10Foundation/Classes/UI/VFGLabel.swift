//
//  VFGLabel.swift
//  VFGMVA10Foundation
//
//  Created by Hussien Gamal Mohammed on 7/9/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

/// Designable UILabel that allows customisation of font, size and type. the default font for VFGLabel is VodafoneRegular.
@IBDesignable
public class VFGLabel: UILabel {
    @IBInspectable var fontName: Int = 0 {
        willSet(newValue) {
            font = font(of: FontType(rawValue: newValue) ?? FontType.lite, with: fontSize)
        }
    }

    @IBInspectable var fontSize: CGFloat = 22 {
        willSet(newValue) {
            font = font(of: FontType(rawValue: fontName) ?? FontType.lite, with: newValue)
        }
    }

	@IBInspectable var isCopyable: Bool = false {
		didSet {
			if isCopyable {
				addLongPressMenuItems()
			} else {
				removeLongPressMenuItems()
			}
		}
	}

    public override var text: String? {
        didSet {
            if UIView.appearance().semanticContentAttribute == .forceRightToLeft, textAlignment != .center {
                self.textAlignment = .right
            }
        }
    }

    public override var attributedText: NSAttributedString? {
        didSet {
            if UIView.appearance().semanticContentAttribute == .forceRightToLeft, textAlignment != .center {
                self.textAlignment = .right
            }
        }
    }

    func font(of type: FontType, with size: CGFloat) -> UIFont {
        switch type {
        case .regular:
            return UIFont.vodafoneRegular(size)
        case .lite:
            return UIFont.vodafoneLite(size)
        case .bold:
            return UIFont.vodafoneBold(size)
        }
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                if UIView.appearance().semanticContentAttribute == .forceRightToLeft, textAlignment != .center {
                    textAlignment = .right
                }
            }
        }
    }
}

enum FontType: Int {
    case lite = 0
    case regular = 1
    case bold = 2
}


extension UILabel {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if UIView.appearance().semanticContentAttribute == .forceRightToLeft, textAlignment != .center {
            self.textAlignment = .right
        }
    }
}
