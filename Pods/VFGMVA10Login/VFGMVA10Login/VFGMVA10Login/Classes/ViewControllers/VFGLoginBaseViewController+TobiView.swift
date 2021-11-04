//
//  VFGLoginBaseViewController+TobiView.swift
//  VFGLogin
//
//  Created by Esraa Eldaltony on 1/29/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

// MARK: TOBI
/* Business logic for tobi */
extension VFGLoginBaseViewController: VFGTobiHandlerDelegate {
    func begin(animation: VFGTOBIAnimationNames, tobiLessImage: UIImage = UIImage()) {
        if isTobiEnabled {
            tobiFace.begin(animation, animateNow: true)
        } else {
            tobiLessImageView.image = tobiLessImage
        }
    }
}
