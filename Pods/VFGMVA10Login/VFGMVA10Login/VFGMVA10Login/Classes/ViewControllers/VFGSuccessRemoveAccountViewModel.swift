//
//  VFGSuccessRemoveAccountViewModel.swift
//  VFGMVA10Login
//
//  Created by Hamsa Hassan on 5/25/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

class VFGSuccessRemoveAccountViewModel {
    weak var delegate: VFGEditAccountListStateInternalProtocol?
    weak var accountDelegate: VFGLoginAccountsListProtocol?
    var removedAccount: VFGAccount
    init (
        with editAccountDelegate: VFGEditAccountListStateInternalProtocol?,
        accountDelegate: VFGLoginAccountsListProtocol?,
        removedAccount: VFGAccount
    ) {
        delegate = editAccountDelegate
        self.accountDelegate = accountDelegate
        self.removedAccount = removedAccount
        DispatchQueue.main.async {
            self.delegate?.presentSuccessView()
        }
    }
}

extension VFGSuccessRemoveAccountViewModel: VFQuickActionsModel {
    func closeQuickAction() {
        delegate?.successViewFinished()
    }

    func quickActionsProtocol(delegate: VFQuickActionsProtocol) {}

    var quickActionsTitle: String {
        "registered_account_edit_your_account_list_label".localized(bundle: .login)
    }

    var quickActionsContentView: UIView {
        guard let successRemoveActionView: VFGSuccessRemoveAccountView =
        VFGSuccessRemoveAccountView.loadXib(bundle: Bundle.login),
        let accountDelegate = accountDelegate else {
            return UIView()
        }
        successRemoveActionView.delegate = delegate
        successRemoveActionView.configure(with: removedAccount, accountDelegate: accountDelegate)
        return successRemoveActionView
    }

    var quickActionsStyle: VFQuickActionsStyle {
        .white
    }
}
