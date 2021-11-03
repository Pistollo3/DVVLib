//
//  UIView+Shadow.swift
//  VFGMVA10Foundation
//
//  Created by Tomasz Czyżak on 27/05/2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

extension UIView {
    /**
    Add shadow layer to `UIView`

    - Parameter offset: The offset (in points) of the layer’s shadow
    - Parameter radius: The blur radius (in points) used to render the layer’s shadow
    - Parameter opacity: The opacity of the layer’s shadow from 0.0 to 1.0
    */
    public func configureShadow(
        offset: CGSize = CGSize(width: 0.0, height: 2.0),
        radius: CGFloat = 6.0,
        opacity: Float = 0.12,
        shouldRasterize: Bool = false
    ) {
        layer.cornerRadius = radius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
        if shouldRasterize {
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
    }
}
