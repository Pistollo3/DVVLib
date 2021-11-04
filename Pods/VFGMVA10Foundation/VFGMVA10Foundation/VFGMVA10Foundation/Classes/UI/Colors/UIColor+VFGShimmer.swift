//
//  UIColor+VFGShimmer.swift
//  VFGMVA10Foundation
//
//  Created by Hussien Gamal Mohammed on 4/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    /**
    - Light color (Hex) #EDEDED
    - Dark color (Hex) #464646
    */
    public static let VFGShimmerViewEdge = UIColor.init(
        named: "VFGShimmerViewEdge",
        in: Bundle.foundation,
        compatibleWith: nil) ?? UIColor.white

    /**
    - Light color (Hex) #DFDFDF
    - Dark color (Hex) #666666
    */
    public static let VFGShimmerViewCenter = UIColor.init(
        named: "VFGShimmerViewCenter",
        in: Bundle.foundation,
        compatibleWith: nil) ?? UIColor.white
}
