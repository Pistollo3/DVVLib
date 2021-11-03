//
//  VFGAnimatableView.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 3/6/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//
import Lottie

open class VFGAnimatableView: UIView {
    @IBOutlet public weak var animationView: AnimationView!

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()

        guard superview != nil, !animationView.isHidden else {
            return
        }

        animationView.play()
    }
}
