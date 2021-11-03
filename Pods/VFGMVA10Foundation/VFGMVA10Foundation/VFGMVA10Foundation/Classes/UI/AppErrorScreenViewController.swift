//
//  AppErrorScreenViewController.swift
//  VFGMVA10Foundation
//
//  Created by Hamsa Hassan on 3/15/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

/// A configurable view that can be used to show app errors
public class AppErrorScreenViewController: UIViewController {
    @IBOutlet weak var errorTitle: VFGLabel!
    @IBOutlet weak var errorMessage: VFGLabel!
    @IBOutlet weak var buttonAction: VFGButton!
    @IBOutlet weak var dismissAction: VFGButton!
    @IBOutlet weak var errorImageView: VFGImageView!

    /// Controls the visibility of the close button in the top right corner
    private var hasDismissAction: Bool {
        appErrorDismissAction != nil
    }

    public var appErrorButtonAction: (() -> Void)?
    public var appErrorDismissAction: (() -> Void)? {
        didSet {
            dismissAction.isHidden = !hasDismissAction
        }
    }

    /**
    Configuring error title and description

    - Parameter title: header title
    - Parameter message: body message description
    - Parameter buttonText: button title
    */
    public func configure(
        title: String,
        message: String,
        buttonText: String,
        accessibilityIdInitial: String? = nil
    ) {
        if !title.isEmpty,
            !description.isEmpty,
            !buttonText.isEmpty {
            errorTitle.text = title
            errorMessage.text = message
            buttonAction.setTitle(buttonText, for: .normal)
        }

        setupAccessibilityIds(accessibilityIdInitial)
    }

    @IBAction func buttonActionPressed(_ sender: Any) {
        appErrorButtonAction?()
    }

    @IBAction func dismissActionPressed(_ sender: Any) {
        appErrorDismissAction?()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        _ = self.view
    }

    func setupAccessibilityIds(_ accessibilityIdInitial: String?) {
        guard let accessibilityIdInitial = accessibilityIdInitial else {
            return
        }

        errorTitle.accessibilityIdentifier = accessibilityIdInitial + "errorTitle"
        errorMessage.accessibilityIdentifier = accessibilityIdInitial + "errorDesc"
        errorImageView.accessibilityIdentifier = accessibilityIdInitial + "warningIcon"
        buttonAction.accessibilityIdentifier = accessibilityIdInitial + "actionButton"
        dismissAction.accessibilityIdentifier = accessibilityIdInitial + "actionDismiss"
    }
}
