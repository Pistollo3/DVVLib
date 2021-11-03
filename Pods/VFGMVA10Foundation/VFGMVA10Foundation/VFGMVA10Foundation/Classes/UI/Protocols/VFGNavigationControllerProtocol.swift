//
//  VFGNavigationControllerProtocol.swift
//  VFGMVA10Foundation
//
//  Created by Moamen Abd Elgawad on 08/07/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public protocol VFGNavigationControllerProtocol: AnyObject {
    func closeButtonDidPress()
    func backButtonDidPress()
}

extension VFGNavigationControllerProtocol {
    public func backButtonDidPress() {}
}
