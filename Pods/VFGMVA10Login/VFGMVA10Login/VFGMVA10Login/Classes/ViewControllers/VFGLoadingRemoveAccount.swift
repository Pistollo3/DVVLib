//
//  VFGLoadingRemoveAccount.swift
//  VFGMVA10Login
//
//  Created by Hamsa Hassan on 5/25/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit
import Lottie
import VFGMVA10Foundation

class VFGLoadingRemoveAccount: UIView {
    @IBOutlet weak var loadingLabel: VFGLabel!
    @IBOutlet weak var animationView: AnimationView!

    func configure(with account: VFGAccount) {
        animationView.animation = Animation.vodafoneLogo
        animationView.play()
        animationView.loopMode = .loop
        loadingLabel.text = String(
            format: "confirm_remove_account_removing_account_label".localized(bundle: Bundle.login),
            "\(account.name)")
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        animationView.animation = Animation.vodafoneLogo
        animationView.play()
        animationView.loopMode = .loop
    }
}
