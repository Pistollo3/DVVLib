//
//  AnimationHelper.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 12/21/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Lottie

extension Animation {
    // MARK: - Vodafone Logo
    public static var vodafoneLogoWhite = Animation.named("vodafoneLogoWhite", bundle: .foundation)
    public static var vodafoneLogoRed = Animation.named("vodafoneLogoRed", bundle: .foundation)
    public static var vodafoneLogo: Animation? {
        if #available(iOS 13.0, *) {
            if UIApplication.topViewController()?.traitCollection.userInterfaceStyle == .dark {
                return vodafoneLogoWhite
            } else {
                return vodafoneLogoRed
            }
        }

        return vodafoneLogoRed
    }

    // MARK: - Tick
    public static var tickRed = Animation.named("Top-up_Tick_Red", bundle: .foundation)
    public static var tickWhite = Animation.named("Top-up_Tick_White", bundle: .foundation)
    public static var tick: Animation? {
        if #available(iOS 13.0, *) {
            if UIApplication.topViewController()?.traitCollection.userInterfaceStyle == .dark {
                return tickWhite
            } else {
                return tickRed
            }
        }

        return tickRed
    }
}
