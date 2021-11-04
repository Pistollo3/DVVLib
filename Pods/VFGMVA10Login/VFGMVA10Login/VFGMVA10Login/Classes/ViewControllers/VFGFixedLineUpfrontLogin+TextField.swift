//
//  VFGFixedLineUpfrontLogin+TextField.swift
//  VFGMVA10Login
//
//  Created by Hussien Gamal Mohammed Fahmy on 19/05/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation
extension VFGFixedLineUpfrontLogin: VFGTextFieldProtocol {
    public func vfgTextFieldDidBeginEditing(_ vfgTextField: VFGTextField) {
        if isErrorMessageShown {
            backToFullState()
        }
        if vfgTextField == passwordTextField {
            passwordTextField.hideError()
            passwordTextField.getFocuesd()
        }
        if vfgTextField == userNameTextField {
            userNameTextField.hideError()
            userNameTextField.getFocuesd()
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

        if vfgTextField == userNameTextField, text.isEmpty ||
            text.count < fixedLineUpfrontLoginDelegate?.usernameLengthRange.lowerBound ?? 0 {
            nextButton.isEnabled = false
        }

        if vfgTextField == passwordTextField,
            text.isEmpty ||
            text.count < fixedLineUpfrontLoginDelegate?.passwordLengthRange.lowerBound ?? 0 {
            nextButton.isEnabled = false
        }

        validationTimer.invalidate()
        validationTimer = Timer.scheduledTimer(withTimeInterval: validationDelay, repeats: false) { timer in
            timer.invalidate()
            self.checkFrontendValidation()
        }
    }

    func checkFrontendValidation() {
        let isUserNameValid = checkUserNameValidation(text: userNameTextField.textFieldText)
        let isPasswordValid = checkPasswordValidation(text: passwordTextField.textFieldText)
        guard isUserNameValid && isPasswordValid else {
            nextButton.isEnabled = false
            return
        }
        if !nextButton.isEnabled {
            nextButton.isEnabled = true
            fixedLineUpfrontLoginDelegate?.tobiDelegate?.begin(
                animation: .wink,
                tobiLessImage: UIImage.VFGLogo.dynamic ?? UIImage())
        }
    }

    func checkUserNameValidation(text: String) -> Bool {
        if text.isEmpty ||
            text.count <
            fixedLineUpfrontLoginDelegate?.usernameLengthRange.lowerBound ?? 0 {
            userNameTextField.hideError()
            return false
        }
        if fixedLineUpfrontLoginDelegate?.isFrontendValid(emailOrPhone: text) ?? false {
            userNameTextField.hideError()
            return true
        } else {
            userNameTextField
                .showError(title: "upfront_login_error_enter_valid_email".localized(bundle: .login))
            return false
        }
    }

    func checkPasswordValidation(text: String) -> Bool {
        if text.isEmpty ||
            text.count <
            fixedLineUpfrontLoginDelegate?.passwordLengthRange.lowerBound ?? 0 {
            passwordTextField.hideError()
            return false
        }

        if fixedLineUpfrontLoginDelegate?.isValidPassword(password: text) ?? false {
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
            passwordTextField.isSecureTextEntry = !passwordInsightIsHidden
            passwordTextField.textFieldRightIcon = !passwordInsightIsHidden
                ? passwordInsightShowImage : passwordInsightHide
            passwordInsightIsHidden.toggle()
        }
    }
}
