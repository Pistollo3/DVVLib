//
//  VFGLoginBaseViewController+BlockingView.swift
//  VFGLogin
//
//  Created by Esraa Eldaltony on 11/5/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import VFGMVA10Foundation

extension VFGLoginBaseViewController: VFGLoginHandleBlockingViewProtocol {
    func addBlockingView(userEmail: String) {
        if isEmailLoginPresented {
            upfrontLoginObj?.hideAllErrorMessages()
        }
        blockingView = VFGLoginBlockingView(userEmail: userEmail)
        guard let blockingView = blockingView else {
            return
        }
        blockingView.twoActionsDelegate = self
        VFQuickActionsViewController.presentQuickActionsViewController(with: blockingView)
    }

    func removeBlockingView() {
        blockingView?.delegate?.closeQuickAction(completion: nil)
    }
}

extension VFGLoginBaseViewController: VFGTwoActionsViewProtocol {
    func primaryButtonAction() {
        presentEmailLoginViewController()
        removeBlockingView()
        upfrontLoginObj?.resetAccount()
    }
    func secondaryButtonAction() {
        presentEmailLoginViewController()
        removeBlockingView()
    }
}
