//
//  UIImage+Toggle.swift
//  VFGMVA10Media
//
//  Created by Yahya Saddiq on 3/2/21.
//

import UIKit

extension UIImage {
    public enum VFGToggle {
        public enum Medium {
            public static let active = UIImage(
                named: "toggleMediumActive",
                in: foundation,
                compatibleWith: nil
            )
            public static let inactive = UIImage(
                named: "toggleMediumInactive",
                in: foundation,
                compatibleWith: nil
            )
        }

        public enum Small {
            public static let active = UIImage(
                named: "toggleSmallActive",
                in: foundation,
                compatibleWith: nil
            )
            public static let inactive = UIImage(
                named: "toggleSmallInactive",
                in: foundation,
                compatibleWith: nil
            )
        }
    }

    public enum VFGRadioButton {
        public static let active = UIImage(
            named: "VFGRadioButtonActive",
            in: foundation,
            compatibleWith: nil
        )
        public static let inactive = UIImage(
            named: "VFGRadioButtonInactive",
            in: foundation,
            compatibleWith: nil
        )
    }
}
