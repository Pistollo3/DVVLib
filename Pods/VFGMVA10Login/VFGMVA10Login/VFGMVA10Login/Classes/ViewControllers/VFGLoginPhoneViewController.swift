//
//  PhoneNumberLoginViewController.swift
//  VFGLogin
//
//  Created by Esraa Eldaltony on 7/9/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation

/// Soft login view controller
class VFGLoginPhoneViewController: UIViewController, VFGTextFieldProtocol {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nextButton: VFGButton!
    @IBOutlet weak var phoneTextField: VFGTextField!

    weak var loginManagerNavigationDelegate: VFGLoginManagerNavigationProtocol?
    weak var softLoginDelegate: VFGSoftLoginProtocol?
    weak var loginManagerDelegate: VFGSoftLoginInternalProtocol?
    weak var loginErrorMessageDelegate: VFGLoginHandleErrorMessageProtocol?
    weak var loadingDelegate: VFGShowHideLoadingLogoProtocol?
    var upFrontLoginAvailable = true
    var validationTimer = Timer()
    var validationDelay: TimeInterval = 0.8

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        setupAccessibilityIds()
    }
    fileprivate func setupAccessibilityIds() {
        phoneTextField.setTextFieldIdentifier(with: PhoneAccessibilityIds.phoneTextField.rawValue)
        phoneTextField.setErrorHintLabelIdentifier(with: PhoneAccessibilityIds.errorHintLabelIdentifier.rawValue)
    }
    private func configureUi() {
        nextButton.titleLabel?.font = UIFont.vodafoneRegular(18)
        nextButton.setTitle("soft_login_next_label".localized(bundle: Bundle.login), for: .normal)
        if phoneTextField.textFieldText.isEmpty {
            nextButton.isEnabled = false
        }
        phoneTextField.delegate = self
        phoneTextField.configureTextField(
            topTitleText: "soft_login_hint".localized(bundle: Bundle.login),
            placeHolder: "soft_login_hint".localized(bundle: Bundle.login),
            inputType: UIKeyboardType.phonePad)

        // TextField Configuration
        phoneTextField.maxLength = softLoginDelegate?.phoneMaxLength
        phoneTextField.allowedCharacters = softLoginDelegate?.phoneAllowedCharacters
    }
    // MARK: Actions
    func loginWithUserName() {
        phoneTextField.resignFirstResponder()
        loginManagerNavigationDelegate?.navigateToLoginEmail()
    }

    @IBAction func nextButtonDidPress(_ sender: Any) {
        validationTimer.invalidate()
        let validationError: CredentialsValidationState =
            softLoginDelegate?.validate(phoneNumber: phoneTextField.textFieldText) ?? CredentialsValidationState.invalid
        nextButton.isUserInteractionEnabled = false
        switch validationError {
        case .valid:
            self.hideErrorMessage()
            self.phoneTextField.backToFullState()
            sendSMS()
        case .invalidFormat:
            nextButton.isUserInteractionEnabled = true
            phoneTextField.showError(title: "soft_login_add_valid_phone_number".localized(bundle: Bundle.login))
        default:
            nextButton.isUserInteractionEnabled = true
            phoneTextField.showError(title: "soft_login_add_valid_phone_number".localized(bundle: Bundle.login))
        }
    }

    func showErrorMessage(title: String) {
        loginErrorMessageDelegate?.showErrorMessageView(title: title)
        loginErrorMessageDelegate?
            .setupAccessibilityIdentifier(titleId: PhoneAccessibilityIds.errorMassageViewTitle.rawValue)
        phoneTextField.showError()
    }

    func hideErrorMessage() {
        loginErrorMessageDelegate?.hideErrorMessageView()
        phoneTextField.hideError()
    }
    // MARK: VFGTextField delegate
    func textFieldStateChange(_ vfgTextField: VFGTextField) {
        phoneTextField.hideError()
        validationTimer.invalidate()
        checkFrontendValidation(text: vfgTextField.textFieldText)
    }
    func vfgTextFieldDidBeginEditing(_ vfgTextField: VFGTextField) {
        hideErrorMessage()
        textFieldStateChange(vfgTextField)
    }

    func vfgTextFieldDidEndEditing(_ vfgTextField: VFGTextField) {
        textFieldStateChange(vfgTextField)
    }

    func vfgTextFieldDidChange(_ vfgTextField: VFGTextField, text: String) {
        phoneTextField.hideError()

        if text.isEmpty || text.count < softLoginDelegate?.phoneMinLength ?? 0 {
            nextButton.isEnabled = false
        }

        validationTimer.invalidate()
        validationTimer = Timer.scheduledTimer(withTimeInterval: validationDelay, repeats: false) { timer in
            timer.invalidate()
            self.checkFrontendValidation(text: text)
        }
    }

    func checkFrontendValidation(text: String) {
        if text.isEmpty {
            nextButton.isEnabled = false
            phoneTextField.hideError()
            return
        }
        if text.count < softLoginDelegate?.phoneMinLength ?? 0 { return }
        let validationError = softLoginDelegate?.validate(phoneNumber: text)
        if validationError == .invalidFormat {
            nextButton.isEnabled = false
            phoneTextField.showError(title: "soft_login_add_valid_phone_number".localized(bundle: Bundle.login))
        } else {
            nextButton.isEnabled = true
            phoneTextField.hideError()
        }
    }

    func vfgTextFieldRightButtonClicked(_ vfgTextField: VFGTextField) {
    }
}
