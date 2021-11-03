//
//  VFGFixedLineUpfrontLogin+LoginOTP.swift
//  VFGMVA10Login
//
//  Created by Hussien Gamal Mohammed Fahmy on 19/05/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
extension VFGFixedLineUpfrontLogin: VFGLoginOTPInternalProtocol {
    var changeButtonTitle: String {
        "verification_change_email_text".localized(bundle: Bundle.login)
    }

    func changeButtonDidPress() {
        guard let parentVC = self.parent as? VFGLoginBaseViewController else {
            return
        }
        if parentVC.isLoginVerificationPresented {
            parentVC.presentFixedLineUpfrontLogin()
            parentVC.upfrontLoginObj?.backToFullState()
        }
    }

    func resendButtonDidPress() {
        guard let verificationFixedLineUpfrontLogin = fixedLineUpfrontLoginDelegate as? VFGLoginOTPDelegate else {
            return
        }

        verificationFixedLineUpfrontLogin.sendVerificationCode(
            emailOrPhone: self.userNameTextField.textFieldText,
            completion: nil
        )
    }

    func verificationCodeCompletion(result: VFGLoginResult) {
        loginManagerDelegate?.fixedLineUpFrontCompletion(result: result)
    }

    func buildCompletion() -> (VFGLoginResult, String?) -> Void {
        let completion: (VFGLoginResult, String?) -> Void = { [weak self] result, errorTitle in
            guard let self = self else { return }
            switch result {
            case .success(let userData):
                self.loadingDelegate?.hide(with: true)
                self.hideAllErrorMessages()
                if self.fixedLineUpfrontLoginDelegate is VFGLoginOTPDelegate {
                    self.sendVerificationCode()
                } else {
                    self.loginManagerDelegate?.fixedLineUpFrontCompletion(result: .success(userData: userData))
                }
            case .fail(let error):
                self.loadingDelegate?.hide(with: false)
                self.hideAllErrorMessages()
                switch error as? CredentialsValidationState {
                case .invalidFormat:
                    self.hideErrorMessage()
                    self.hideFixedLineErrorMessage()
                    self.userNameTextField
                        .showError(title: "upfront_login_error_enter_valid_email".localized(bundle: Bundle.login))
                    self.passwordTextField.showError()
                    self.loginManagerDelegate?.fixedLineUpFrontCompletion(
                        result: .fail(error: FixedLineUpfrontLoginError.invalid))
                case .limitedTrials, .invalid:
                    self.userNameTextField.hideError()
                    self.passwordTextField.hideError()
                    self.showFixedLineErrorMessage(title: errorTitle ?? "")
                case .blocked:
                    self.loginHandleBlockingViewDelegate?.addBlockingView(
                        userEmail: self.userNameTextField.textFieldText)
                    self.loginManagerDelegate?.fixedLineUpFrontCompletion(
                        result: .fail(error: FixedLineUpfrontLoginError.blocked))
                default:
                    break
                }
            }
        }
        return completion
    }

    func sendVerificationCode() {
        loadingDelegate?.show(with: "verification_verifying_login_code_text".localized(bundle: Bundle.login))
        guard let verificationFixedLineUpfrontLogin = fixedLineUpfrontLoginDelegate as? VFGLoginOTPDelegate else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            verificationFixedLineUpfrontLogin.sendVerificationCode(
                emailOrPhone: self.userNameTextField.textFieldText
            ) { [weak self] result, errorMessageTitle in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.loadingDelegate?.hide(with: true)
                    self.loginManagerNavigationDelegate?
                        .navigateToLoginOTP(
                            emailOrPhone: self.userNameTextField.textFieldText,
                            completionDelegate: self
                        )
                case .fail:
                    self.loadingDelegate?.hide(with: false)
                    self.showErrorMessage(title: errorMessageTitle ?? "")
                }
                self.nextButton.isUserInteractionEnabled = true
            }
        }
    }
}
