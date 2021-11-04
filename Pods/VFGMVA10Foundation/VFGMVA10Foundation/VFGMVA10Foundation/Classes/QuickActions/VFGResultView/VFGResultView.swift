//
//  VFGQuickActionsResultView.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 12/30/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit
import Lottie

public class VFGResultView: VFGAnimatableView {
    @IBOutlet weak var primaryButton: VFGButton!
    @IBOutlet weak var titleLabel: VFGLabel!
    @IBOutlet weak var descriptionLabel: VFGLabel!
    @IBOutlet weak var imageView: VFGImageView!
    @IBOutlet weak var secondaryButton: VFGButton!
    @IBOutlet weak var animationViewTopConstraint: NSLayoutConstraint!

    weak var delegate: VFGResultViewProtocol?
    var animationLight: Animation?
    var animationDark: Animation?
    var animation: Animation? {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                return animationLight
            } else {
                return animationDark
            }
        }
        return animationLight
    }

    public func configure(
        model: VFGQuickActionsResultModel,
        accessibilityModel: VFGResultViewAccessibilityModel? = nil,
        topMargin: CGFloat = 32,
        backgroundColor: UIColor = .clear
    ) {
        delegate = model.delegate
        titleLabel.font = model.titleFont
        descriptionLabel.font = model.descriptionFont
        titleLabel.text = model.titleText
        descriptionLabel.text = model.descriptionText
        primaryButton.setTitle(model.buttonTitle, for: .normal)
        primaryButton.titleLabel?.font = model.primaryButtonFont
        if let secondaryButtonTitle = model.secondaryButtonTitle {
            secondaryButton.setTitle(secondaryButtonTitle, for: .normal)
            secondaryButton.titleLabel?.font = model.secondaryButtonFont
        } else {
            secondaryButton.isHidden = true
        }
        switch model.type {
        case .success:
            animationLight = Animation.tickRed
            animationDark = Animation.tickWhite
            animationView.animation = animation
        case .failure:
            imageView.image = VFGImage(named: "icWarningHiLightTheme")
        case .customImage(let image):
            imageView.image = image
        case let .customAnimation(lightAnimation, darkAnimation):
            animationLight = lightAnimation
            animationDark = darkAnimation ?? lightAnimation
            animationView.animation = animation
        case .none:
            animationView.isHidden = true
            imageView.isHidden = true
        }
        animationViewTopConstraint.constant = topMargin
        self.backgroundColor = backgroundColor
        if let accessibilityModel = accessibilityModel {
            setupAccessibility(with: accessibilityModel)
        }
    }

    func setupAccessibility(with model: VFGResultViewAccessibilityModel) {
        titleLabel.accessibilityIdentifier = model.titleID
        descriptionLabel.accessibilityIdentifier = model.descriptionID
        imageView.accessibilityIdentifier = model.imageViewID
        animationView.accessibilityIdentifier = model.imageViewID
        primaryButton.accessibilityIdentifier = model.primaryButtonID
        secondaryButton.accessibilityIdentifier = model.secondaryButtonID
    }

    @IBAction func primaryButtonDidPress(_ sender: Any) {
        delegate?.resultViewPrimaryButtonAction()
    }
    @IBAction func secondaryButtonDidPress(_ sender: Any) {
        delegate?.resultViewSecondaryButtonAction()
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(
                comparedTo: previousTraitCollection
            ) {
                animationView.animation = animation
                animationView.currentProgress = 1
            }
        }
    }
}
