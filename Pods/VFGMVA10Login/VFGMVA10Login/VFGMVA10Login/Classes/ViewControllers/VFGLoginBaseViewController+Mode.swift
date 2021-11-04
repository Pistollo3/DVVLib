//
//  VFGLoginBaseViewController+Mode.swift
//  VFGMVA10Login
//
//  Created by Ashraf Dewan on 15/09/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

extension VFGLoginBaseViewController {
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                backgroundView.layer.sublayers?.first?.removeFromSuperlayer()
                backgroundView.setGradientBackgroundColor(colors: UIColor.VFGBackgroundRedGradient)
            }
        }
    }
}
