//
//  VFGEditAccountListStateInternalProtocol.swift
//  VFGMVA10Login
//
//  Created by Essam Orabi on 18/05/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

protocol VFGEditAccountListStateInternalProtocol: class {
    // MARK: - edit screen
    func presentEditAccountListView()
    func editAccountListFinished(selectedAccount: VFGAccount)

    // MARK: - remove screen
    func presentRemoveAccountView()
    func removeFinished(selectedAccount: VFGAccount)

    // MARK: - loading
    func presentLoadingView()
    func loadingViewFinished(success: Bool, showContactSupportButton: Bool, account: VFGAccount)

    // MARK: - Success screen
    func presentSuccessView()
    func successViewFinished()

    // MARK: - Failure screen
    func presentFailureView()
    func failureViewFinished()

    // MARK: - dismiss
    func dismissQuickAction()

    // MARK: - back to edit screen
    func backToEditScreen()

    // MARK: - Contact Support
    func contactSupportAction()
}
