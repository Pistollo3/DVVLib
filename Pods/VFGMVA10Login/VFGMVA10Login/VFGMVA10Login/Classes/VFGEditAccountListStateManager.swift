//
//  VFGEditAccountListStateManager.swift
//  VFGMVA10Login
//
//  Created by Hamsa Hassan on 5/25/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

class VFGEditAccountListStateManager {
    weak var loginManagerNavigationDelegate: VFGLoginManagerNavigationProtocol?
    var state: VFQuickActionsModel?
    weak var quickActionsDelegate: VFQuickActionsProtocol?
    weak var accountProvider: VFGLoginAccountsListProtocol?
    var removedAccount: VFGAccount?
    init(with provider: VFGLoginAccountsListProtocol?) {
        accountProvider = provider
    }

    func setup() {
        editAccount()
    }

    func setState(state: VFQuickActionsModel? = nil) {
        self.state = state
    }

    // Edit Account List
    var editAccountListViewModel: VFGEditAccountListViewModel?
    func editAccount() {
        editAccountListViewModel = VFGEditAccountListViewModel(
            accountDelegate: accountProvider,
            editAccountDelegate: self)
        setState(state: editAccountListViewModel)
    }

    // Remove Account
    var removeAccountViewModel: VFGRemoveAccountViewModel?
    func removeAccount(selectedAccount: VFGAccount) {
        removeAccountViewModel = VFGRemoveAccountViewModel(
            editAccountDelegate: self,
            removeAccount: selectedAccount)
        setState(state: removeAccountViewModel)
    }

    // Loading
    var loadingRemoveAccountViewModel: VFGLoadingRemoveAccountViewModel?
    func loadingRemoveAccount(selectedAccount: VFGAccount) {
        loadingRemoveAccountViewModel = VFGLoadingRemoveAccountViewModel(with: self, removeAccount: selectedAccount)
        setState(state: loadingRemoveAccountViewModel)
    }

    // Success
    var successRemoveAccountViewModel: VFGSuccessRemoveAccountViewModel?
    func successRemoveAccount(removedAccount: VFGAccount) {
        successRemoveAccountViewModel = VFGSuccessRemoveAccountViewModel(
            with: self,
            accountDelegate: accountProvider,
            removedAccount: removedAccount
        )
        setState(state: successRemoveAccountViewModel)
    }

    // Failure
    var removeAccountFailureViewModel: VFGRemoveAccountFailureViewModel?
    func removeAccountFailure(account: VFGAccount, showContactSupportButton: Bool) {
        removeAccountFailureViewModel = VFGRemoveAccountFailureViewModel(
            with: self,
            account: account,
            showContactSupportButton: showContactSupportButton)
        setState(state: removeAccountFailureViewModel)
    }
}

extension VFGEditAccountListStateManager: VFQuickActionsModel {
    public func closeQuickAction() {
        quickActionsDelegate?.closeQuickAction(completion: nil)
    }

    public func quickActionsProtocol(delegate: VFQuickActionsProtocol) {
        self.quickActionsDelegate = delegate
    }

    public var quickActionsTitle: String {
        state?.quickActionsTitle ?? ""
    }

    public var quickActionsContentView: UIView {
        state?.quickActionsContentView ?? UIView()
    }

    public var quickActionsStyle: VFQuickActionsStyle {
        state?.quickActionsStyle ?? .white
    }

    public func backQuickAction() {
        quickActionsDelegate?.reloadQuickAction(
            model: editAccountListViewModel ?? VFGEditAccountListStateManager(with: nil))
    }
}

extension VFGEditAccountListStateManager: VFGEditAccountListStateInternalProtocol {
    func presentEditAccountListView() {
        VFQuickActionsViewController.presentQuickActionsViewController(
            with: self)
    }

    func editAccountListFinished(selectedAccount: VFGAccount) {
        removeAccount(selectedAccount: selectedAccount)
    }

    func presentRemoveAccountView() {
        quickActionsDelegate?.reloadQuickAction(model: removeAccountViewModel)
    }

    func removeFinished(selectedAccount: VFGAccount) {
        loadingRemoveAccount(selectedAccount: selectedAccount)
        accountProvider?.delete(selectedAccount) { status, showContactSupportButton  in
        guard let status = status else { return }
            self.loadingViewFinished(
                success: status,
                showContactSupportButton: showContactSupportButton ?? false,
                account: selectedAccount)
        }
    }

    func presentLoadingView() {
        quickActionsDelegate?.reloadQuickAction(model: loadingRemoveAccountViewModel)
    }

    func loadingViewFinished(success: Bool, showContactSupportButton: Bool, account: VFGAccount) {
        if success {
            successRemoveAccount(removedAccount: account)
        } else {
            removeAccountFailure(account: account, showContactSupportButton: showContactSupportButton)
        }
    }

    func presentSuccessView() {
        quickActionsDelegate?.reloadQuickAction(model: successRemoveAccountViewModel)
    }

    func successViewFinished() {
        guard let accounts = accountProvider?.retrieveSavedAccounts() else { return }
        if accounts.count < 1 {
            loginManagerNavigationDelegate?.navigateToChooseAccount()
            dismissQuickAction()
        } else {
            loginManagerNavigationDelegate?.navigateToSavedAccounts()
            backQuickAction()
        }
    }

    func presentFailureView() {
        quickActionsDelegate?.reloadQuickAction(model: removeAccountFailureViewModel)
    }

    func failureViewFinished() {
        quickActionsDelegate?.reloadQuickAction(model: editAccountListViewModel)
    }

    func dismissQuickAction() {
        quickActionsDelegate?.closeQuickAction(completion: nil)
    }

    func backToEditScreen() {
        backQuickAction()
    }

    func contactSupportAction() {
        accountProvider?.contactSupportAction()
    }
}
