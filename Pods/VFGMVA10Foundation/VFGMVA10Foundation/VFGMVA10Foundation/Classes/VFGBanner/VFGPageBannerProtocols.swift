//
//  VFGPageBannerProtocols.swift
//  VFGMVA10Foundation
//
//  Created by Hamsa Hassan on 9/1/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public protocol VFGPageBannerDismissProtocol: class {
    func dismissBanner()
}

public protocol VFGPageBannerProtocol: class {
    func primaryButtonDidSelect(for pageBanner: VFGPageBanner)
    func secondaryButtonDidSelect(for pageBanner: VFGPageBanner)
    func switchButtonDidSelect(for pageBanner: VFGPageBanner)
}
