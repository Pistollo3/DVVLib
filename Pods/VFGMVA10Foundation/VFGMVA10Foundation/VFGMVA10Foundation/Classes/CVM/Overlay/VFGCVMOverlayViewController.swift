//
//  VFCVMOverlayViewController.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 8/25/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

/// A full screen overlay which contains image, title, subtitle, X button, action button
public class VFGCVMOverlayViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: VFGImageView!
    @IBOutlet weak var mainImageView: VFGImageView!
    @IBOutlet weak var rightImageView: VFGImageView!
    @IBOutlet weak var rightImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftImageView: VFGImageView!
    @IBOutlet weak var titleLabel: VFGLabel!
    @IBOutlet weak var subTitleLabel: VFGLabel!
    @IBOutlet weak var confirmButton: VFGButton!

    public var contentView: UIView?
    /// A closure that is called when clicking on the X button
    public var dismissCompletion: (() -> Void)?
    /// A closure that is called when clicking on the action button
    public var confirmCompletion: (() -> Void)?
    var overlayViewModel: VFGCVMOverlayViewModel?

    public override var prefersStatusBarHidden: Bool {
        return true
    }

    public convenience init(with model: VFGCVMOverlayViewModel) {
        self.init(
            nibName: String(describing: VFGCVMOverlayViewController.self),
            bundle: Bundle.foundation)
        overlayViewModel = model
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        guard let overlayModel = overlayViewModel else { return }

        backgroundImageView.image = overlayModel.backgroundImage ?? UIImage(named: "greyBG", in: .foundation)
        mainImageView.image = overlayModel.mainIcon
        titleLabel.text = overlayModel.title
        subTitleLabel.text = overlayModel.content
        confirmButton.setTitle(overlayModel.confirmTitle, for: .normal)

        switch overlayModel.style {
        case .birthday:
            rightImageView.image = UIImage(named: "star", in: .foundation)
            leftImageView.image = UIImage(named: "star", in: .foundation)
        case let .custom(rightIcon, leftIcon):
            rightImageView.image = rightIcon
            if rightIcon == nil {
                rightImageHeightConstraint.constant = 0
                rightImageBottomConstraint.constant = 0
            }
            leftImageView.image = leftIcon
        }
    }

    @IBAction func dismissOverlayPressed(_ sender: Any) {
        dismissCompletion?()
    }

    @IBAction func confirmButtonDidPress(_ sender: Any) {
        confirmCompletion?()
    }
}
