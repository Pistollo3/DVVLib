//
//  VFGShimmerView.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Mahmoud Zaki on 1/6/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation
/// A generic UIView provides a shimmer while loading data or until a screen or view is ready to show.
public class VFGShimmerView: UIView {
    private var gradientColorOne = UIColor.VFGShimmerViewEdge.cgColor
    private var gradientColorTwo = UIColor.VFGShimmerViewCenter.cgColor

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        gradientColorOne = UIColor.VFGShimmerViewEdge.cgColor
        gradientColorTwo = UIColor.VFGShimmerViewCenter.cgColor
    }

    /**
    Start animation
    - Colors are predefined as VFGShimmerViewEdge and VFGShimmerViewCenter.

    - Parameter duration: The shimmer effect duration by seconds, default is 1 sec
    - Parameter completion: An optional completion closure to be called when the animation start
    */
    public func startAnimation(
        duration: TimeInterval = 1.0,
        completion: (() -> Void)? = nil
    ) {
        isHidden = false
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.layer.masksToBounds = true
            let gradientLayer = CAGradientLayer()
            var frame = self.bounds
            frame.size.width *= 2
            gradientLayer.frame = frame
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.colors = [self.gradientColorOne, self.gradientColorTwo, self.gradientColorOne]
            gradientLayer.locations = [0.0, 0.25, 0.75]
            self.layer.addSublayer(gradientLayer)
            let animation = CABasicAnimation(keyPath: "locations")
            animation.fromValue = [-1, -0.75, -0.25]
            animation.toValue = [1, 1.25, 1.75]
            animation.repeatCount = .infinity
            animation.duration = duration
            gradientLayer.add(animation, forKey: animation.keyPath)
            completion?()
        }
    }
}
