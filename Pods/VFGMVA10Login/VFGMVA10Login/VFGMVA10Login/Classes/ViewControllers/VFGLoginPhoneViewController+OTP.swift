//
//  VFGLoginPhoneViewController+OTP.swift
//  VFGMVA10Login
//
//  Created by Hussien Gamal Mohammed Fahmy on 20/05/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

extension VFGLoginPhoneViewController: VFGLoginOTPInternalProtocol {
    var changeButtonTitle: String {
        "verification_change_number_text".localized(bundle: Bundle.login)
    }

    func verificationCodeCompletion(result: VFGLoginResult) {
        loginManagerDelegate?.verificationCodeCompletion(result: result)
    }

    func changeButtonDidPress() {
        guard let parentVC = self.parent as? VFGLoginBaseViewController else {
            return
        }
        if parentVC.isLoginVerificationPresented {
            parentVC.presentPhoneLoginViewController()
            parentVC.loginPhoneObj?.phoneTextField.backToFullState()
        }
    }

    func resendButtonDidPress() {
        softLoginDelegate?.sendVerificationCode(
            emailOrPhone: phoneTextField.textFieldText,
            completion: nil)
    }

    func sendSMS() {
        loadingDelegate?.show(with: "verification_verifying_login_code_text".localized(bundle: Bundle.login))
        guard let softLoginDelegate = softLoginDelegate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {[weak self] in
            guard let self = self else { return }
            softLoginDelegate.sendVerificationCode(
                emailOrPhone: self.phoneTextField.textFieldText
            ) { [weak self] result, errorMessageTitle in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.loadingDelegate?.hide(with: true)
                    self.loginManagerNavigationDelegate?
                        .navigateToLoginOTP(
                            emailOrPhone: self.phoneTextField.textFieldText,
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
