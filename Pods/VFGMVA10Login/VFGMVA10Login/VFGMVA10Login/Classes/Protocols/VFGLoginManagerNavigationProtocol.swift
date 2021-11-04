//
//  VFGLoginManagerNavigationProtocol.swift
//  VFGLogin
//
//  Created by Esraa Eldaltony on 7/25/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

/**
Login manager navigation methods.
- navigateToLoginEmail: Navigate to upfront login view controller.
- navigateToLoginVerfication: Navigate to soft login verification view controller.
- navigate: Navigate to passed view controller.
*/
protocol VFGLoginManagerNavigationProtocol: class {
    func navigateToLoginEmail()
    func navigateToLoginOTP(emailOrPhone: String, completionDelegate: VFGLoginOTPInternalProtocol?)
    func navigateToSavedAccounts()
    func navigateToFixedLine()
    func navigateToChooseAccount()
    func navigateToMobileServiceLogin()
    func navigate(to viewController: UIViewController)
}
