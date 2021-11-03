//
//  VFGTobiHandlerDelegate.swift
//  VFGLogin
//
//  Created by Hussien Gamal Mohammed on 11/12/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

/**
VFGTobiHandlerDelegate.
- begin: Begins Tobi animation.
*/
public protocol VFGTobiHandlerDelegate: class {
    func begin(animation: VFGTOBIAnimationNames, tobiLessImage: UIImage)
}
