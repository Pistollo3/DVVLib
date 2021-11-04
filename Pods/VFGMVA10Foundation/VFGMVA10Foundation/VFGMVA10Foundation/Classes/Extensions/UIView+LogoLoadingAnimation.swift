//
//  UIView+LogoLoadingAnimation.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 12/31/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation
import Lottie

public extension UIView {
    func startLogoLoadingAnimation(
        animation: Animation? = Animation.vodafoneLogoWhite,
        backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.6),
        title: String? = nil,
        titleFont: UIFont? = nil,
        titleTextColor: UIColor? = nil,
        subtitle: String? = nil
    ) {
        guard let animation = animation else { return }

        VFGLoadingLogoView.loadingLogoView = VFGLoadingLogoView.loadXib(bundle: .foundation)
        VFGLoadingLogoView.loadingLogoView?.configure(
            animation: animation,
            view: self,
            backgroundColor: backgroundColor,
            title: title,
            titleFont: titleFont,
            titleTextColor: titleTextColor,
            subtitle: subtitle
        )
        VFGLoadingLogoView.loadingLogoView?.startLoading()
    }

    func endLogoLoadingAnimation() {
        VFGLoadingLogoView.loadingLogoView?.endLoading()
        VFGLoadingLogoView.loadingLogoView = nil
    }
}
