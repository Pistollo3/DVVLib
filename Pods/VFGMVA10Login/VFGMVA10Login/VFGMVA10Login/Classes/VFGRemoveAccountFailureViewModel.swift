//
//  VFGRemoveAccountFailureViewModel.swift
//  VFGMVA10Login
//
//  Created by Essam Orabi on 06/06/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

class VFGRemoveAccountFailureViewModel {
    weak var editAccountDelegate: VFGEditAccountListStateInternalProtocol?
    public var account: VFGAccount?
    var showContactSupportButton: Bool?
    init (
        with editAccountDelegate: VFGEditAccountListStateInternalProtocol?,
        account: VFGAccount,
        showContactSupportButton: Bool
    ) {
        self.editAccountDelegate = editAccountDelegate
        self.account = account
        self.showContactSupportButton = showContactSupportButton
        DispatchQueue.main.async {
            self.editAccountDelegate?.presentFailureView()
        }
    }
}

extension VFGRemoveAccountFailureViewModel: VFQuickActionsModel {
    var quickActionsTitle: String {
        return "registered_account_edit_your_account_list_label".localized(bundle: Bundle.login)
    }

    var quickActionsContentView: UIView {
        guard let removeAccountFailureView: VFGRemoveAccountFailureView = UIView.loadXib(bundle: Bundle.login),
        let account = account else { return UIView() }
        removeAccountFailureView.delegate = self
        removeAccountFailureView.configureLabel(
            account: account,
            showContactSupportButton: showContactSupportButton ?? false)
        return removeAccountFailureView
    }

    func quickActionsProtocol(delegate: VFQuickActionsProtocol) {}

    func closeQuickAction() {
        editAccountDelegate?.dismissQuickAction()
    }

    var quickActionsStyle: VFQuickActionsStyle {
        .white
    }
}

extension VFGRemoveAccountFailureViewModel: VFGRemoveAccountFailureDelegate {
    func contactSupportDidPress() {
        editAccountDelegate?.contactSupportAction()
    }

    func tryAgainButtonDidPress() {
        guard let account = account else {
            return
        }
        editAccountDelegate?.removeFinished(selectedAccount: account)
    }

    func cancelButtonDidPress() {
        editAccountDelegate?.dismissQuickAction()
    }
}
