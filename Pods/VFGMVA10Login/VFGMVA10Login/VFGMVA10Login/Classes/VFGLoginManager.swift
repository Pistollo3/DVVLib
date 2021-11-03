//
//  LoginManager.swift
//  VFGLogin
//
//  Created by Hussien Gamal Mohammed on 7/24/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import VFGMVA10Foundation

/// Variant options to detect exactly the state of login.
public enum CredentialsValidationState: Error {
    case invalidFormat
    case valid
    case invalid
    case limitedTrials
    case blocked
}

/// Manager that controls the whole login journey.
open class VFGLoginManager {
    weak var loginManagerDelegate: VFGLoginManagerDelegate?

    var navigationController: UINavigationController?
    var softLoginImplementation: VFGSoftLoginProtocol?
    var upfrontLoginImplementation: VFGUpfrontLoginProtocol?
    var seamlessLoginImplementation: VFGSeamlessLoginProtocol?
    var fixedLineUpFrontLoginImplementation: VFGFixedLineUpfrontLoginProtocol?
    var loginAccountsListImplementation: VFGLoginAccountsListProtocol?
    var loginPhoneObj: VFGLoginPhoneViewController?
    var upfrontLoginObj: VFGLoginEmail?
    var loginAccountsListObj: VFGLoginAccountsList?
    var isTobiEnabled = true
    var initialScreen: VFGLoginScreensType?

    public var isUserLoggedIn: Bool?
    private var seamlessLoginController: VFGSeamlessLogin?

    static public var isBiometricEnabled = false
    static public var currentLanguage = ""

    var loginBaseViewController: VFGLoginBaseViewController?

    // MARK: - Seamless Login Internal Protocol
    /**
    Login manager initializer.
    - Parameters:
        - softLoginProtocol: implementation of soft login flow.
        - upfrontLoginProtocol: implementation of upfront login flow.
        - seamlessLoginProtocol: implementation of seamless login flow.
        - loginAccountsListProtocol: implementation of accounts list screen.
        - loginManagerDelegate: implementation of login manager methods.
        - isTobiEnabled: define if Tobi should be enabled or not.
    */
    public init(
        softLoginProtocol: VFGSoftLoginProtocol? = nil,
        upfrontLoginProtocol: VFGUpfrontLoginProtocol? = nil,
        seamlessLoginProtocol: VFGSeamlessLoginProtocol? = nil,
        fixedLineLoginProtocol: VFGFixedLineUpfrontLoginProtocol? = nil,
        loginAccountsListProtocol: VFGLoginAccountsListProtocol? = nil,
        loginManagerDelegate: VFGLoginManagerDelegate?,
        isTobiEnabled: Bool? = true
    ) {
        softLoginImplementation = softLoginProtocol
        upfrontLoginImplementation = upfrontLoginProtocol
        seamlessLoginImplementation = seamlessLoginProtocol
        fixedLineUpFrontLoginImplementation = fixedLineLoginProtocol
        loginAccountsListImplementation = loginAccountsListProtocol
        self.loginManagerDelegate = loginManagerDelegate
        seamlessLoginController = VFGSeamlessLogin(delegate: seamlessLoginImplementation)
        seamlessLoginController?.internalDelegate = self
        self.isTobiEnabled = isTobiEnabled ?? true
    }

    /// Starts login flow.
    open func login(initialScreen: VFGLoginScreensType? = nil) {
        if initialScreen != nil {
            self.initialScreen = initialScreen
            handleLoginFlowWithoutSeamless()
            return
        }
        if seamlessLoginImplementation != nil {
            seamlessLoginController?.loginSilently()
        } else {
            handleLoginFlowWithoutSeamless()
        }
    }

    public func navigate(to screenType: VFGLoginScreensType) {
        loginBaseViewController?.present(screenType: screenType)
    }

    /**
    Present login view controller.
    - Parameters:
        - delay: delay for presenting login view controller.
    */
    func presentLoginBaseViewController(delay: TimeInterval = TimeInterval(1)) {
        loginBaseViewController = VFGLoginBaseViewController.instance()
        guard let loginBaseViewController = loginBaseViewController else { return }
        loginBaseViewController.upfrontLoginImplementation = upfrontLoginImplementation
        loginBaseViewController.softLoginImplementation = softLoginImplementation
        loginBaseViewController.accountsListLoginImplementation = loginAccountsListImplementation
        loginBaseViewController.fixedLineUpfrontLoginProtocol = fixedLineUpFrontLoginImplementation
        loginBaseViewController.softLoginInternalProtocol = self
        loginBaseViewController.upfrontLoginInternalProtocol = self
        loginBaseViewController.fixedLineupfrontLoginInternalProtocol = self
        loginBaseViewController.isTobiEnabled = isTobiEnabled
        loginBaseViewController.initialScreen = initialScreen

        seamlessLoginImplementation?.tobiDelegate = loginBaseViewController
        softLoginImplementation?.tobiDelegate = loginBaseViewController
        upfrontLoginImplementation?.tobiDelegate = loginBaseViewController
        loginAccountsListImplementation?.tobiDelegate = loginBaseViewController
        fixedLineUpFrontLoginImplementation?.tobiDelegate = loginBaseViewController

        navigationController = UINavigationController(rootViewController: loginBaseViewController)
        loginBaseViewController.loginNavigationController = navigationController

        if let navigationController = navigationController {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                guard let delegate = self.loginManagerDelegate else { return }
                delegate.present(viewController: navigationController)
            }
        }
    }

    /// Present the proper login flow other than seamless.
    func handleLoginFlowWithoutSeamless() {
        if initialScreen != nil {
            presentLoginBaseViewController()
            return
        }
        // check if softLogin is not nil
        if softLoginImplementation != nil || upfrontLoginImplementation != nil
            || fixedLineUpFrontLoginImplementation != nil {
            presentLoginBaseViewController()
        } else {
            loginManagerDelegate?.onFinish(result: .fail(error: nil), dismiss: nil)
        }
    }

    /// Dismiss Login view controller.
    func dismissLoginController() -> UIViewController? {
        guard let navigationController = navigationController else {
            return nil
        }
        return navigationController
    }

    func setLoginType(_ loginType: String, userData: [String: Any]?) -> VFGLoginResult {
        var userData = userData

        userData?["loginType"] = loginType
        return VFGLoginResult.success(userData: userData)
    }
}

extension VFGLoginManager: VFGUpfrontLoginInternalProtocol {
    /**
    Handles the completion of upfront login flow.
    - Parameters:
        - result: the state of login either success or failure.
    */
    func upFrontCompletion(result: VFGLoginResult) {
        switch result {
        case .success(let userData):
            isUserLoggedIn = true
            loginManagerDelegate?.onFinish(
                result: setLoginType("upfront", userData: userData),
                dismiss: dismissLoginController())
        case .fail:
            break
        }
    }
}

extension VFGLoginManager: VFGFixedLineUpfrontLoginInternalProtocol {
    /**
    Handles the completion of upfront login flow.
    - Parameters:
        - result: the state of login either success or failure.
    */
    func fixedLineUpFrontCompletion(result: VFGLoginResult) {
        switch result {
        case .success(let userData):
            isUserLoggedIn = true
            loginManagerDelegate?.onFinish(
                result: setLoginType("fixedLine", userData: userData),
                dismiss: dismissLoginController())
        case .fail:
            break
        }
    }
}
extension VFGLoginManager: VFGSeamlessInternalProtocol {
    /**
    Handles the completion of seamless login flow.
    - Parameters:
        - result: the state of login either success or failure.
    */
    func seamlessCompletion(result: VFGLoginResult) {
        switch result {
        case .success(let userData):
            // navigate to dashboard
            isUserLoggedIn = true
            loginManagerDelegate?.onFinish(
                result: setLoginType("seamless", userData: userData),
                dismiss: dismissLoginController())
        case .fail:
            handleLoginFlowWithoutSeamless()
        }
    }
}

extension VFGLoginManager: VFGSoftLoginInternalProtocol {
    /**
    Handles the completion of verifying verification code.
    - Parameters:
        - result: the state of verification code either success or failure.
    */
    func verificationCodeCompletion(result: VFGLoginResult) {
        switch result {
        case .success(let userData):
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // navigate to dashboard
                self.isUserLoggedIn = true
                self.loginManagerDelegate?.onFinish(
                    result: self.setLoginType("soft", userData: userData),
                    dismiss: self.dismissLoginController())
            }
        case .fail:
            break
        }
    }
}
