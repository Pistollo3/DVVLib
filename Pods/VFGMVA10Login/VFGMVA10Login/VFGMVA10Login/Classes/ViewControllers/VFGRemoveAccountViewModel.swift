//
//  VFGRemoveAccountViewModel.swift
//  VFGMVA10Login
//
//  Created by Hamsa Hassan on 5/25/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

class VFGRemoveAccountViewModel: VFQuickActionsModel {
    weak var editAccountDelegate: VFGEditAccountListStateInternalProtocol?
    weak var twoActionsDelegate: VFGTwoActionsViewProtocol?
    public var quickActionsTitle: String = ""
    public var removeAccount: VFGAccount?
    init (
        editAccountDelegate: VFGEditAccountListStateInternalProtocol?,
        removeAccount: VFGAccount
    ) {
        self.editAccountDelegate = editAccountDelegate
        self.removeAccount = removeAccount
        DispatchQueue.main.async {
            self.editAccountDelegate?.presentRemoveAccountView()
        }
    }

    var quickActionsContentView: UIView {
        guard let removeAccountView: VFGRemoveAccountView = UIView.loadXib(bundle: Bundle.login),
        let removeAccount = removeAccount else {
            return UIView()
        }

        removeAccountView.configureLabels(removeAccount: removeAccount)
        removeAccountView.delegate = self
        return removeAccountView
    }

    func quickActionsProtocol(delegate: VFQuickActionsProtocol) {}

    func closeQuickAction() {
        editAccountDelegate?.dismissQuickAction()
    }

    var quickActionsStyle: VFQuickActionsStyle {
        .white
    }
}

extension VFGRemoveAccountViewModel: VFGRemoveAccountProtocol {
    func removeAccountButtonPressed() {
        guard let selectedAccount = removeAccount else {
            return
        }
        editAccountDelegate?.removeFinished(selectedAccount: selectedAccount)
    }

    func backButtonPressed() {
        editAccountDelegate?.backToEditScreen()
    }
}
