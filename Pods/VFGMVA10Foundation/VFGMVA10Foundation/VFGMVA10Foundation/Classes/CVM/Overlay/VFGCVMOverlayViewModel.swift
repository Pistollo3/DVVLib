//
//  VFCVMOverlayViewModel.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 8/27/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

/// CVM overlay style
public enum VFGCVMOverlayStyle {
    /// Shows two stars images on the right & left
    case birthday
    /// Shows custom images for both right & left
    case custom(rightIcon: UIImage?, leftIcon: UIImage?)
}

/// A model that can be injected to VFGCVMOverlayViewController
public struct VFGCVMOverlayViewModel {
    var title: String
    var content: String
    var confirmTitle: String
    var mainIcon: UIImage
    var backgroundImage: UIImage?
    var style: VFGCVMOverlayStyle = .birthday
/**
- Parameter title: The title that appears under the image
- Parameter content: The description
- Parameter confirmTitle: The button text
- Parameter mainIcon: The main image
- Parameter backgroundImage: The screen's background
- Parameter style: The overlay style
*/
    public init(
        title: String,
        content: String,
        confirmTitle: String,
        mainIcon: UIImage,
        backgroundImage: UIImage? = nil,
        style: VFGCVMOverlayStyle = .birthday
    ) {
        self.title = title
        self.content = content
        self.confirmTitle = confirmTitle
        self.mainIcon = mainIcon
        self.backgroundImage = backgroundImage
        self.style = style
    }
}
