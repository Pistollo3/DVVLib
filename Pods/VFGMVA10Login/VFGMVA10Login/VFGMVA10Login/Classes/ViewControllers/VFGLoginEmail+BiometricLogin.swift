//
//  VFGLoginEmail+BiometricLogin.swift
//  VFGMVA10Login
//
//  Created by Moustafa Hegazy on 15/08/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation
import LocalAuthentication

extension VFGLoginEmail {
    func loginLogic(username: String, password: String) {
        let completion: (VFGLoginResult, String?) -> Void
        let emailOrPhone = username
        let password = password
        completion = loginCompletion(userName: emailOrPhone, password: password)
        validationTimer.invalidate()
        loginErrorMessageDelegate?.hideErrorMessageView()
        upfrontLoginDelegate?.loginButtonDidPress { [weak self] in
            self?.loadingDelegate?.show(with: "verification_loading_login_text".localized(bundle: Bundle.login))
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {[weak self] in
                guard let self = self else { return }
                self.upfrontLoginDelegate?.login(
                    emailOrPhone: emailOrPhone,
                    password: password,
                    rememberMe: self.buttonToggledOn,
                    completion: completion)
            }
        }
        loginButton.isEnabled = true
    }

    func setupBiometricLoginUI(username: String, password: String) {
        if VFGLoginManager.isBiometricEnabled, !username.isEmpty, !password.isEmpty {
            if biometricManager.canEvaluate().0 {
                switch biometricManager.authenticationContext.biometryType {
                case .faceID:
                    biometricLoginButton.setTitle("Use face ID", for: .normal)
                    biometricTypeImageView.image = VFGImage(named: "icFaceRecognitionRed")
                case .touchID:
                    biometricLoginButton.setTitle("Use Touch ID", for: .normal)
                    biometricTypeImageView.image = VFGImage(named: "icBiometricAuthenticationRed")
                default:
                    hideBiometricButton()
                }
            } else {
                hideBiometricButton()
            }
        } else {
            hideBiometricButton()
        }
    }

    func hideBiometricButton() {
        biometricStackView.isHidden = true
        biometricStackViewHightConstraint.constant = 0
    }

    func authenticateDeviceOwner(
        username: String,
        password: String,
        completion: @escaping ((Error?) -> Void)
    ) {
        if VFGLoginManager.isBiometricEnabled {
            if !username.isEmpty, !password.isEmpty {
                if biometricManager.canEvaluate().0 {
                    biometricManager.authenticate { success, error  in
                        if success {
                            completion(nil)
                        } else {
                            completion(error)
                        }
                    }
                }
            }
        }
    }

    func authenticateBiometricLogin() {
        let (username, password) = retrieveCredentialsFromKeychain()
        self.loginLogic(username: username, password: password)
    }

    @discardableResult
    func saveCredentialsToKeychain(userName: String, password: String) -> Bool {
        let usernameAndPassword = "\(userName) \(password)"
        guard let data = usernameAndPassword.data(using: .utf32) else { return false }

        VFGKeyChainService.saveData(key: Bundle.login.applicationName, value: data)
        return true
    }

    func retrieveCredentialsFromKeychain() -> (userName: String, password: String) {
        let credentials = VFGKeyChainService.data(forKey: Bundle.login.applicationName)
        let usernamePassword = String(data: credentials ?? Data(), encoding: .utf32)
        let credentialsArray = usernamePassword?.split(separator: " ", maxSplits: 1).map(String.init)
        if credentialsArray?.count == 2 {
            guard let username = credentialsArray?[0], let password = credentialsArray?[1] else { return ("", "") }
            return (username, password)
        } else {
            return ("", "")
        }
    }
}
