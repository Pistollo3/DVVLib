//
//  UIImage+Close.swift
//  VFGMVA10Media
//
//  Created by Yahya Saddiq on 3/5/21.
//

import UIKit

extension UIImage {
    public enum VFGClose {
        public static let white = UIImage(
            named: "icCloseWhite",
            in: foundation,
            compatibleWith: nil
        )
        public static let dynamic = UIImage(
            named: "icClose",
            in: foundation,
            compatibleWith: nil
        )
    }

    public enum VFGArrow {
        public static let right = UIImage(
            named: "icArrowLeft",
            in: foundation,
            compatibleWith: nil
        )
        public static let left = UIImage(
            named: "icArrowLeft",
            in: foundation,
            compatibleWith: nil
        )
    }
}
