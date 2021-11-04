//
//  VFGCVMProtocol.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed AbdElnabi on 31/08/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public protocol VFGCVMProtocol: AnyObject {
    func closeButtonDidPress()
    func setupButtonDidPress()
    func editButtonDidPress()
    func toggleButtonDidPress(isToggleEnabled: Bool)
}

public extension VFGCVMProtocol {
    func editButtonDidPress() {}
    func toggleButtonDidPress(isToggleEnabled: Bool = false) {}
}
