//
//  VFGLoginEmail+TextField.swift
//  VFGMVA10Login
//
//  Created by Hussien Gamal Mohammed Fahmy on 19/05/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation
extension VFGLoginEmail: VFGTextFieldProtocol {
    public func vfgTextFieldDidBeginEditing(_ vfgTextField: VFGTextField) {
        if isErrorMessageShown {
            backToFullState()
        }
        if vfgTextField == passwordTextField {
            passwordTextField.hideError()
            passwordTextField.getFocuesd()
        }
        if vfgTextField == emailTextField {
            emailTextField.hideError()
            emailTextField.getFocuesd()
        }
        validationTimer.invalidate()
        checkFrontendValidation()
    }

    public func vfgTextFieldDidEndEditing(_ vfgTextField: VFGTextField) {
        hideErrorMessage()
        vfgTextField.hideError()
        validationTimer.invalidate()
        checkFrontendValidation()
    }

    public func vfgTextFieldDidChange(_ vfgTextField: VFGTextField, text: String) {
        hideErrorMessage()
        vfgTextField.hideError()

        if vfgTextField == emailTextField,
            text.isEmpty ||
            text.count < upfrontLoginDelegate?.mailLengthRange.lowerBound ?? 0 {
            loginButton.isEnabled = false
        }

        if vfgTextField == passwordTextField,
            text.isEmpty ||
            text.count < upfrontLoginDelegate?.passwordLengthRange.lowerBound ?? 0 {
            loginButton.isEnabled = false
        }

        validationTimer.invalidate()
        validationTimer = Timer.scheduledTimer(withTimeInterval: validationDelay, repeats: false) { timer in
            timer.invalidate()
            self.checkFrontendValidation()
        }
    }

    func checkFrontendValidation() {
        let isEmailValid = checkEmailValidation(text: emailTextField.textFieldText)
        let isPasswordValid = checkPasswordValidation(text: passwordTextField.textFieldText)
        guard isEmailValid && isPasswordValid else {
            loginButton.isEnabled = false
            return
        }
        if !loginButton.isEnabled {
            loginButton.isEnabled = true
            upfrontLoginDelegate?.tobiDelegate?.begin(
                animation: .wink,
                tobiLessImage: UIImage.VFGLogo.dynamic ?? UIImage())
        }
    }

    func checkEmailValidation(text: String) -> Bool {
        if text.isEmpty ||
            text.count <
            upfrontLoginDelegate?.mailLengthRange.lowerBound ?? 0 {
            emailTextField.hideError()
            return false
        }
        if upfrontLoginDelegate?.isFrontendValid(emailOrPhone: text) ?? false {
            emailTextField.hideError()
            return true
        } else {
            emailTextField
                .showError(title: "upfront_login_error_enter_valid_email".localized(bundle: .login))
            return false
        }
    }

    func checkPasswordValidation(text: String) -> Bool {
        if text.isEmpty ||
            text.count <
            upfrontLoginDelegate?.passwordLengthRange.lowerBound ?? 0 {
            passwordTextField.hideError()
            return false
        }

        if upfrontLoginDelegate?.isValidPassword(password: text) ?? false {
            passwordTextField.hideError()
            return true
        } else {
            passwordTextField
                .showError(title: "upfront_login_error_enter_valid_password".localized(bundle: .login))
            return false
        }
    }

    func vfgTextFieldRightButtonClicked(_ vfgTextField: VFGTextField) {
        let passwordInsightShowImage = UIImage.VFGPassword.show
        let passwordInsightHide = UIImage.VFGPassword.hide
        if vfgTextField == passwordTextField {
            showPasswordInsights.toggle()
            passwordTextField.isSecureTextEntry = !showPasswordInsights
            passwordTextField.textFieldRightIcon = !showPasswordInsights
                ? passwordInsightShowImage : passwordInsightHide
        }
    }
}
