//
//  VFGRemoveAccountFailureView.swift
//  VFGMVA10Login
//
//  Created by Essam Orabi on 02/06/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation

protocol VFGRemoveAccountFailureDelegate: AnyObject {
    func tryAgainButtonDidPress()
    func cancelButtonDidPress()
    func contactSupportDidPress()
}

class VFGRemoveAccountFailureView: UIView {
    @IBOutlet weak var mainTitleLabel: VFGLabel!
    @IBOutlet weak var descriptionLabel: VFGLabel!
    @IBOutlet weak var tryAgainButton: VFGButton!
    @IBOutlet weak var returnToAccountsButton: VFGButton!

    weak var delegate: VFGRemoveAccountFailureDelegate?
    var tryAgainPressed = false
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDataLabels()
    }

    func configureLabel(account: VFGAccount, showContactSupportButton: Bool) {
        descriptionLabel.text = String(
            format: "confirm_remove_account_you_could_not_remove_account_label".localized(bundle: Bundle.login),
            "\(account.name)")
        tryAgainButton.setTitle(
            showContactSupportButton ?
                "confirm_remove_account_contact_support_button".localized(
                    bundle: Bundle.login) : "confirm_remove_account_try_again_button".localized(
                        bundle: Bundle.login), for: .normal)
        tryAgainPressed = showContactSupportButton
    }
    func setupDataLabels() {
        mainTitleLabel.text = "confirm_remove_account_something_went_wrong_label".localized(bundle: Bundle.login)
        returnToAccountsButton.setTitle(
            "confirm_remove_account_return_to_accounts_button".localized(bundle: Bundle.login), for: .normal)
        tryAgainButton.setTitle(
            "confirm_remove_account_try_again_button".localized(bundle: Bundle.login), for: .normal)
    }

    @IBAction func tryAgainButtonDidPress(_ sender: VFGButton) {
        if tryAgainPressed {
            delegate?.contactSupportDidPress()
        } else {
            delegate?.tryAgainButtonDidPress()
        }
    }

    @IBAction func returnToAccountsButtonDidPress(_ sender: VFGButton) {
        delegate?.cancelButtonDidPress()
    }
}
