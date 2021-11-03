//
//  VFGLoginBaseViewController+Navigation.swift
//  VFGMVA10Login
//
//  Created by Ashraf Dewan on 04/09/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import VFGMVA10Foundation

extension VFGLoginBaseViewController: VFGLoginManagerNavigationProtocol {
    func navigate(to viewController: UIViewController) {
        loginNavigationController?.pushViewController(viewController, animated: true)
    }

    func navigateToLoginEmail() {
        presentEmailLoginViewController()
    }

    func navigateToLoginOTP(emailOrPhone: String, completionDelegate: VFGLoginOTPInternalProtocol?) {
        loginVerification?.verificationDelegate = verificationOTPImplementation
        presentLoginVerificationViewController(emailOrPhone: emailOrPhone, completionDelegate: completionDelegate)
    }

    func navigateToSavedAccounts() {
        presentAccountsListViewController()
    }

    func navigateToFixedLine() {
        presentFixedLineUpfrontLogin()
    }

    func navigateToChooseAccount() {
        presentChooseAccountType()
    }

    func navigateToMobileServiceLogin() {
        if softLoginImplementation != nil {
            presentPhoneLoginViewController()
        } else if upfrontLoginImplementation != nil {
            presentEmailLoginViewController()
        }
    }
}
