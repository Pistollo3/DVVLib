//
//  VFGLoadingRemoveAccountViewModel.swift
//  VFGMVA10Login
//
//  Created by Hamsa Hassan on 5/25/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

class VFGLoadingRemoveAccountViewModel {
    weak var delegate: VFGEditAccountListStateInternalProtocol?
    var removeAccount: VFGAccount?

    init (
        with delegate: VFGEditAccountListStateInternalProtocol?,
        removeAccount: VFGAccount
    ) {
        self.delegate = delegate
        self.removeAccount = removeAccount
        DispatchQueue.main.async {
            self.delegate?.presentLoadingView()
        }
    }
}

extension VFGLoadingRemoveAccountViewModel: VFQuickActionsModel {
    func closeQuickAction() {
        delegate?.dismissQuickAction()
    }

    func quickActionsProtocol(delegate: VFQuickActionsProtocol) {}

    public var quickActionsTitle: String {
        "registered_account_edit_your_account_list_label".localized(bundle: .login)
    }

    var quickActionsContentView: UIView {
        guard let loadingRemoveAccountView: VFGLoadingRemoveAccount =
            VFGLoadingRemoveAccount.loadXib(bundle: Bundle.login),
            let removeAccount = removeAccount else {
            return UIView()
        }
        loadingRemoveAccountView.configure(with: removeAccount)
        return loadingRemoveAccountView
    }

    var quickActionsStyle: VFQuickActionsStyle {
        .white
    }

    var isCloseButtonHidden: Bool {
        true
    }
}
