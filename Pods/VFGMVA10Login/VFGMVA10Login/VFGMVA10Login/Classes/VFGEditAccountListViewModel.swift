//
//  VFGEditAccountListViewModel.swift
//  VFGMVA10Login
//
//  Created by Essam Orabi on 18/05/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

class VFGEditAccountListViewModel: VFQuickActionsModel {
    weak var accountDelegate: VFGLoginAccountsListProtocol?
    weak var editAccountDelegate: VFGEditAccountListStateInternalProtocol?
    weak var delegate: VFGEditAccountListStateManager?

    init (
        accountDelegate: VFGLoginAccountsListProtocol?,
        editAccountDelegate: VFGEditAccountListStateInternalProtocol?
    ) {
        self.accountDelegate = accountDelegate
        self.editAccountDelegate = editAccountDelegate
        DispatchQueue.main.async {
            self.editAccountDelegate?.presentEditAccountListView()
        }
    }

    func numberOfSavedAccounts() -> Int {
        let savedAccounts = accountDelegate?.retrieveSavedAccounts().map { VFGAccountItemCellViewModel(account: $0) }
            ?? []
        return savedAccounts.count
    }

    var quickActionsTitle: String {
        let localizedCountsLabelText = "registered_account_edit_dialog_title".localized(bundle: Bundle.login)
        let count = numberOfSavedAccounts()
        let formattedCount = String(format: localizedCountsLabelText, "\(count)")
        return formattedCount
    }

    var quickActionsContentView: UIView {
        guard let editAccountListView: VFGEditAccountListView = UIView.loadXib(bundle: Bundle.login)
        else { return UIView() }
        editAccountListView.delegate = self
        editAccountListView.accountsListDelegate = accountDelegate
        return editAccountListView
    }

    func quickActionsProtocol(delegate: VFQuickActionsProtocol) {}

    func closeQuickAction() {
        editAccountDelegate?.dismissQuickAction()
    }

    var quickActionsStyle: VFQuickActionsStyle {
        .white
    }
}

extension VFGEditAccountListViewModel: VFGEditAccountListDelegate {
    func deleteButtonDidPress(selectedAccount: VFGAccount) {
        editAccountDelegate?.editAccountListFinished(selectedAccount: selectedAccount)
    }

    func cancelButtonDidPress() {
        editAccountDelegate?.dismissQuickAction()
    }
}
