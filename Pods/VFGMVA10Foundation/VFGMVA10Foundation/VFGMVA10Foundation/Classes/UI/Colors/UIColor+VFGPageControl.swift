//
//  UIColor+VFGPageControl.swift
//  VFGMVA10Foundation
//
//  Created by Hussein Kishk on 5/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    /**
    - Light color (Hex) #E60000
    - Dark color (Hex) #FFFFFF
    */
    public static let VFGPageControlCurrentPage = UIColor.init(
        named: "VFGPageControlCurrentPage",
        in: Bundle.foundation,
        compatibleWith: nil) ?? UIColor.white

    /**
    - Light color (Hex) #CCCCCC
    - Dark color (Hex) #666666
    */
    public static let VFGPageControlTint = UIColor.init(
        named: "VFGPageControlTint",
        in: Bundle.foundation,
        compatibleWith: nil) ?? UIColor.white
}
