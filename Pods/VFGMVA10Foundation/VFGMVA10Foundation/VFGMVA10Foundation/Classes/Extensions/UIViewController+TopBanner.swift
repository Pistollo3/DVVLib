//
//  UIViewController+TopBanner.swift
//  VFGMVA10Foundation
//
//  Created by Atta Ahmed on 12/17/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation
extension UIViewController {
    public func showTopBanner(
        message: String,
        imageName: String,
        duration: Double,
        defaultBannerViewHight: CGFloat = 73.0
    ) {
        guard let bannerView: VFGTopBannerView =
        VFGTopBannerView.loadXib(bundle: Bundle.foundation, nibName: "VFGTopBannerView") else {
            return
        }
        bannerView.frame = CGRect(
            x: .zero,
            y: .zero,
            width: view.frame.width,
            height: defaultBannerViewHight
        )
        var viewDisplacementFromTop = defaultBannerViewHight
        if UIScreen.screenHasNotch {
            viewDisplacementFromTop -= UIApplication.shared.statusBarFrame.height
        }
        view.addSubview(bannerView)
        view.bounds.origin.y -= viewDisplacementFromTop
        bannerView.frame.origin.y -= viewDisplacementFromTop
        bannerView.bringSubviewToFront(view)
        bannerView.configure(message: message, imageName: imageName)

        DispatchQueue.main.asyncAfter(deadline: .now() + duration ) { [weak self] in
            bannerView.removeFromSuperview()
            self?.view.bounds.origin.y = .zero
        }
    }
}
