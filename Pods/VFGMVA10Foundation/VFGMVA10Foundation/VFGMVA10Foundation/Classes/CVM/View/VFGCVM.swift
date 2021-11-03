//
//  VFGCVM.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed AbdElnabi on 29/08/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit

open class VFGCVM: UIView {
    // MARK: - properties
    @IBOutlet weak var cvmBannerView: UIView!
    @IBOutlet weak var cvmBackgroundView: UIView!
    @IBOutlet weak var cvmBannerIcon: VFGImageView!
    @IBOutlet weak var titleLabel: VFGLabel!
    @IBOutlet weak var closeButton: VFGButton!
    @IBOutlet weak var descriptionLabel: VFGLabel!
    @IBOutlet weak var setupButton: VFGButton!
    @IBOutlet weak var editButton: VFGButton!
    @IBOutlet weak var toggleButton: VFGButton!
    @IBOutlet weak var autoTopUpActiveCircle: VFGImageView!

    weak var delegate: VFGCVMProtocol?
    var isToggleButtonEnabled = true
    var title: String?
    var titleWhenDisabled: String?

    public override func awakeFromNib() {
        super.awakeFromNib()
        cvmBackgroundView.roundCorners()
        configureShadow()
    }

    // MARK: - initializers
    public func configure(with viewModel: VFGCVMViewModel, isActive: Bool = false) {
        title = viewModel.title
        titleWhenDisabled = viewModel.titleWhenDisabled
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        self.delegate = viewModel.delegate
        self.setupCVMView(isActive: isActive, buttonTitle: viewModel.buttonTitle)
    }

    func setupCVMView(isActive: Bool = false, buttonTitle: String) {
        setupButton.setTitle(buttonTitle, for: .normal)
        editButton.isHidden = !isActive
        toggleButton.isHidden = !isActive
        autoTopUpActiveCircle.isHidden = !isActive
        setupButton.isHidden = isActive
        closeButton.isHidden = isActive
        cvmBannerIcon.isHidden = isActive
        if isActive {
            editButton.setTitle(buttonTitle, for: .normal)
            titleLabel.textColor = .VFGPrimaryText
            descriptionLabel.textColor = .VFGPrimaryText
        } else {
            setupGradientBackground()
        }
    }

    func setupGradientBackground() {
        cvmBackgroundView.setGradientBackgroundColor(
            colors: UIColor.VFGCVMBlueGradient,
            startPoint: CGPoint(x: 1, y: 0),
            endPoint: CGPoint(x: 0, y: 0)
        )
    }

    func toggleDidPress() {
        isToggleButtonEnabled.toggle()
        if isToggleButtonEnabled {
            titleLabel.text = title
            autoTopUpActiveCircle.image = VFGImage(named: "greenCircle")
            toggleButton.setImage(VFGImage(named: "toggleSmallActive"), for: .normal)
        } else {
            titleLabel.text = titleWhenDisabled
            autoTopUpActiveCircle.image = VFGImage(named: "redCircle")
            toggleButton.setImage(VFGImage(named: "toggleSmallInactive"), for: .normal)
        }
        descriptionLabel.isEnabled = isToggleButtonEnabled
    }

    // MARK: - actions
    @IBAction func closeDidPress(_ sender: VFGButton) {
        delegate?.closeButtonDidPress()
    }

    @IBAction func setupDidPress(_ sender: VFGButton) {
        delegate?.setupButtonDidPress()
    }

    @IBAction func editDidPress(_ sender: VFGButton) {
        delegate?.editButtonDidPress()
    }

    @IBAction func toggleDidPress(_ sender: VFGButton) {
        self.toggleDidPress()
        delegate?.toggleButtonDidPress(isToggleEnabled: isToggleButtonEnabled)
    }
}
