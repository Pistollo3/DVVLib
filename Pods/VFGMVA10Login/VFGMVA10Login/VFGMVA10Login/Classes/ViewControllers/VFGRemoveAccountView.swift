//
//  VFGRemoveAccountView.swift
//  VFGMVA10Login
//
//  Created by Hamsa Hassan on 5/18/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

public class VFGRemoveAccountView: UIView {
    @IBOutlet weak var titleLabel: VFGLabel!
    @IBOutlet weak var subTitleLabel: VFGLabel!
    @IBOutlet weak var removeAccountButton: VFGButton!
    @IBOutlet weak var backButton: VFGButton!

    weak var delegate: VFGRemoveAccountProtocol?

    public override func awakeFromNib() {
        super.awakeFromNib()
        setupLabels()
    }

    public func setupLabels() {
        removeAccountButton.setTitle(
            "confirm_remove_account_remove_account_button".localized(bundle: .login),
            for: .normal)
        backButton.setTitle("confirm_remove_account_back_button".localized(bundle: .login), for: .normal)
    }

    public func configureLabels(removeAccount: VFGAccount) {
        titleLabel.text = String(
            format: "confirm_remove_account_remove_account_label".localized(bundle: Bundle.login),
            "\(removeAccount.name)")
        subTitleLabel.text = removeAccount.msisdn
    }


    @IBAction func removeAccountButtonPressed(_ sender: Any) {
        delegate?.removeAccountButtonPressed()
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        delegate?.backButtonPressed()
    }
}

public protocol VFGRemoveAccountProtocol: AnyObject {
    func removeAccountButtonPressed()
    func backButtonPressed()
}
