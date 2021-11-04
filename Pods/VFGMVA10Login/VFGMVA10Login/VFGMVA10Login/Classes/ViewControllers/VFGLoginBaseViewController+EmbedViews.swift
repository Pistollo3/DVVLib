//
//  VFGLoginBaseViewController+EmbedViews.swift
//  VFGMVA10Login
//
//  Created by Essam Orabi on 15/04/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

extension VFGLoginBaseViewController {
    func embedPhoneLoginViewController() {
        loginPhoneObj = VFGLoginPhoneViewController.instance()
        guard let loginPhoneObj = loginPhoneObj else { return }
        loginPhoneObj.upFrontLoginAvailable = (upfrontLoginImplementation != nil)
        loginPhoneObj.softLoginDelegate = softLoginImplementation
        loginPhoneObj.loginManagerDelegate = softLoginInternalProtocol
        loginPhoneObj.loginManagerNavigationDelegate = self
        loginPhoneObj.loginErrorMessageDelegate = self
        loginPhoneObj.loadingDelegate = self
        loginPhoneObj.view.isHidden = true
        embed(loginPhoneObj, inStackView: stackView)
    }

    func embedEmailViewController() {
        upfrontLoginObj = VFGLoginEmail.instance()
        guard let upfrontLoginObj = upfrontLoginObj else { return }
        upfrontLoginObj.loginManagerDelegate = upfrontLoginInternalProtocol
        upfrontLoginObj.upfrontLoginDelegate = upfrontLoginImplementation
        upfrontLoginObj.loginErrorMessageDelegate = self
        upfrontLoginObj.loginManagerNavigationDelegate = self
        upfrontLoginObj.loginHandleBlockingViewDelegate = self
        upfrontLoginObj.loadingDelegate = self
        upfrontLoginObj.view.isHidden = true
        embed(upfrontLoginObj, inStackView: stackView)
    }
    func embedChooseAccountType() {
        chooseAccountView = VFGChooseAccountTypeViewController.instance()
        guard let chooseAccountView = chooseAccountView else { return }
        chooseAccountView.loginManagerNavigationDelegate = self
        chooseAccountView.view.isHidden = true
        embed(chooseAccountView, inStackView: stackView)
    }

    func embedLoginVerificationViewController() {
        loginVerification = VFGLoginVerification.instance()
        guard let loginVerification = loginVerification else { return }
        loginVerification.verificationDelegate = verificationOTPImplementation
        loginVerification.delegate = loginPhoneObj
        loginVerification.loginErrorMessageDelegate = self
        loginVerification.loadingDelegate = self
        loginVerification.view.isHidden = true
        embed(loginVerification, inStackView: stackView)
    }

    func embedLoginAccountsListViewController() {
        loginAccountsList = VFGLoginAccountsList.instance()
        guard let loginAccountsList = loginAccountsList else { return }
        loginAccountsList.accountsListDelegate = accountsListLoginImplementation
        loginAccountsList.loginManagerNavigationDelegate = self
        loginAccountsList.loadingDelegate = self
        loginAccountsList.view.isHidden = true
        embed(loginAccountsList, inStackView: stackView)
    }

    func embedFixedLineUpfrontLogin() {
        fixedLineLoginObj = VFGFixedLineUpfrontLogin.instance()
        guard let fixedLineLoginObj = fixedLineLoginObj else { return }
        fixedLineLoginObj.loginManagerNavigationDelegate = self
        fixedLineLoginObj.loadingDelegate = self
        fixedLineLoginObj.loginManagerDelegate = fixedLineupfrontLoginInternalProtocol
        fixedLineLoginObj.loginAccountListsDelegate = accountsListLoginImplementation
        fixedLineLoginObj.loginErrorMessageDelegate = self
        fixedLineLoginObj.fixedLineUpfrontLoginDelegate = fixedLineUpfrontLoginProtocol
        fixedLineLoginObj.view.isHidden = true
        embed(fixedLineLoginObj, inStackView: stackView)
    }
}
