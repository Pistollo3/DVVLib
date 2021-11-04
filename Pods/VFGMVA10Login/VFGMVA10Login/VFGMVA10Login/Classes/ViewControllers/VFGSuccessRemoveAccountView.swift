//
//  VFGSuccessRemoveAccountView.swift
//  VFGMVA10Login
//
//  Created by Hamsa Hassan on 5/25/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation
import Lottie

public class VFGSuccessRemoveAccountView: UIView {
    @IBOutlet weak var returnToYourAccountButton: VFGButton!
    @IBOutlet weak var successMainLabel: VFGLabel!
    @IBOutlet weak var successSubtitleLabel: VFGLabel!
    @IBOutlet weak var animationView: AnimationView!

    weak var delegate: VFGEditAccountListStateInternalProtocol?

    public override func awakeFromNib() {
        super.awakeFromNib()
        setupLabels()
    }

    func configure(
        with removedAccount: VFGAccount,
        accountDelegate: VFGLoginAccountsListProtocol
    ) {
        animationView.animation = Animation.tickRed
        animationView.play()
        successSubtitleLabel.text = String(
            format: "confirm_remove_account_you_have_successfully_removed_label".localized(bundle: Bundle.login),
            "\(removedAccount.name)")
        if !accountDelegate.retrieveSavedAccounts().isEmpty {
            returnToYourAccountButton.setTitle(
                "confirm_remove_account_return_to_accounts_button".localized(bundle: .login),
                for: .normal)
        } else {
            returnToYourAccountButton.setTitle(
                "registered_account_edit_dialog_button".localized(bundle: .login),
                for: .normal)
        }
    }

    func setupLabels() {
        successMainLabel.text = "confirm_remove_account_account_removed_label".localized(bundle: .login)
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                let style = traitCollection.userInterfaceStyle
                if style == .dark {
                    animationView.animation = Animation.tickWhite
                } else {
                    animationView.animation = Animation.tickRed
                }
            }
        } else {
            animationView.animation = Animation.tickRed
        }
        animationView.play()
    }

    @IBAction func returnToYourAccountTapped(_ sender: Any) {
        delegate?.successViewFinished()
    }
}
