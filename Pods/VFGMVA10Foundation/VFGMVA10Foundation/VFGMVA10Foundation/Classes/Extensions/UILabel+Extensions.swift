//
//  UILabel+Extensions.swift
//  VFGMVA10Foundation
//
//  Created by Abdullah Soylemez on 30.07.2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit

public extension UILabel {
    func growAndShrink(withDuration duration: TimeInterval = 0.2, scale: CGFloat = 1.2) {
        UILabel.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        } completion: { _ in
            UILabel.animate(withDuration: duration) {
                self.transform = .identity
            }
        }
    }

    func isTruncated(numberOfLines: Int, width: CGFloat? = nil) -> Bool {
        let size = text?.size(withAttributes: [NSAttributedString.Key.font: font as UIFont])
        return ((size?.width ?? 0) / CGFloat(numberOfLines)) > width ?? self.bounds.width
    }
}
