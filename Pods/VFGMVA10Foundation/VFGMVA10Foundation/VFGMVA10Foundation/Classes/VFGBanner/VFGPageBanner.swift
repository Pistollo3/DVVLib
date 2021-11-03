//
//  VFGPageBanner.swift
//  VFGMVA10Foundation
//
//  Created by Hamsa Hassan on 8/31/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public class VFGPageBanner: UIView {
    @IBOutlet public weak var headerLabel: VFGLabel!
    @IBOutlet public weak var switchButton: VFGSwitch!
    @IBOutlet public weak var headerImageView: VFGImageView!
    @IBOutlet weak var closeButton: VFGButton!
    @IBOutlet public weak var descriptionLabel: VFGLabel!
    @IBOutlet weak var primaryButton: VFGButton!
    @IBOutlet weak var secondaryButton: VFGButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var secondaryButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondaryButtonToViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var primaryButtonToViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var primaryToSecondaryConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerImageToHeaderLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerLabelToCloseButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerLabelToSwitchButtonConstraint: NSLayoutConstraint!
    let topBottomInsets: CGFloat = 8
    let leftRightInsets: CGFloat = 16
    public weak var delegate: VFGPageBannerProtocol?
    public weak var myPlanDelegate: VFGPageBannerDismissProtocol?

    @IBAction func closeBanner(_ sender: VFGButton) {
        myPlanDelegate?.dismissBanner()
    }

    @IBAction func primaryButtonAction(_ sender: VFGButton) {
        delegate?.primaryButtonDidSelect(for: self)
    }

    @IBAction func secondaryButtonAction(_ sender: VFGButton) {
        delegate?.secondaryButtonDidSelect(for: self)
    }
    @IBAction func switchButtonAction(_ sender: VFGSwitch) {
        delegate?.switchButtonDidSelect(for: self)
    }

    public func setupUI(model: VFGPageBannerModel) {
        headerLabel.text = model.header
        headerLabel.textColor = model.headerTextColor
        descriptionLabel.text = model.description
        descriptionLabel.textColor = model.descriptionTextColor
        headerImageView.image = model.image
        if let image = model.image {
            headerImageView.image = image
        } else {
            headerImageView.isHidden = true
            headerImageWidthConstraint.constant = 0
            headerImageToHeaderLabelConstraint.constant = 0
        }
        primaryButton.setTitle(model.primaryButton, for: .normal)
        primaryButton.backgroundColor = model.primaryButtonBackgroundColor
        primaryButton.borderColor = model.primaryButtonBorderColor
        primaryButton.setTitleColor(model.primaryButtonTitleColor, for: .normal)
        secondaryButton.setTitle(model.secondaryButton, for: .normal)
        secondaryButton.backgroundColor = model.secondaryButtonBackgroundColor
        secondaryButton.borderColor = model.secondaryButtonBorderColor
        secondaryButton.setTitleColor(model.secondaryButtonTitleColor, for: .normal)
        primaryButton.contentEdgeInsets = UIEdgeInsets(
            top: topBottomInsets,
            left: leftRightInsets,
            bottom: topBottomInsets,
            right: leftRightInsets)
        secondaryButton.contentEdgeInsets = UIEdgeInsets(
            top: topBottomInsets,
            left: leftRightInsets,
            bottom: topBottomInsets,
            right: leftRightInsets)
        if model.secondaryButton.isEmpty {
            secondaryButton.isHidden = true
            primaryButton.buttonStyle = 1
            secondaryButtonWidthConstraint.isActive = false
            secondaryButtonToViewConstraint.isActive = false
            primaryToSecondaryConstraint.priority = .defaultLow
            primaryButtonToViewConstraint.priority = .defaultHigh
        }
        switch model.buttonType {
        case .none:
            switchButton.isHidden = true
            closeButton.isHidden = true
            headerLabelToSwitchButtonConstraint.isActive = false
        case .toggle(let isOn):
            switchButton.isOn = isOn
            switchButton.isHidden = false
            closeButton.isHidden = true
            headerLabelToCloseButtonConstraint.isActive = false
        case .close:
            switchButton.isHidden = true
            closeButton.isHidden = false
            headerLabelToSwitchButtonConstraint.isActive = false
        }
        if model.backgroundColors.count == 1, let backgroundColor = model.backgroundColors.first {
            self.backgroundView.backgroundColor = UIColor(cgColor: backgroundColor)
        } else {
            backgroundView.setGradientBackgroundColor(
                colors: model.backgroundColors,
                startPoint: CGPoint(x: 1, y: 0),
                endPoint: CGPoint(x: 0, y: 0))
        }
    }

    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        backgroundView?.layer.sublayers?.first?.frame = backgroundView.bounds
    }
}
