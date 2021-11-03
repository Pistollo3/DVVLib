//
//  VFGLoginVerification.swift
//  VFGLogin
//
//  Created by Hussien Gamal Mohammed on 7/9/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation

/// Soft login view controller
class VFGLoginVerification: UIViewController {
    @IBOutlet weak var cardView: UIView!
    // MARK: Card contents
    @IBOutlet weak var pinView: VFGPinCodeView!
    @IBOutlet weak var resendButton: VFGButton!
    @IBOutlet weak var codeVerifiedMessageView: UIView!
    @IBOutlet weak var verifyingLabel: VFGLabel!
    // MARK: Description contents
    @IBOutlet weak var detailsSubTitle: VFGLabel!
    @IBOutlet weak var phoneNumberLbl: VFGLabel!
    @IBOutlet weak var pinDetails: VFGLabel!
    @IBOutlet weak var changeNumberButton: VFGButton!
    weak var verificationDelegate: VFGLoginOTPDelegate?
    weak var loadingDelegate: VFGShowHideLoadingLogoProtocol?
    weak var delegate: VFGLoginOTPInternalProtocol?
    weak var loginErrorMessageDelegate: VFGLoginHandleErrorMessageProtocol?
    var phoneNumber: String?
    var animationsDuration: TimeInterval = 0.3
    var tobiAnimationDuration: TimeInterval = 3.0
    var timer: Timer?
    var countdownSeconds = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardDismissHandler()
        setupUI()
        setupAccessibilityIds()
        configurePinView()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopResendButtonTimer()
    }

    // MARK: card contents actions
    @IBAction func resendButtonClicked(_ sender: Any) {
        startResendButtonTimer()
        hideErrorView()
        delegate?.resendButtonDidPress()
    }

    @IBAction func changeNumberButtonClicked(_ sender: Any) {
        delegate?.changeButtonDidPress()
    }

    func configurePinView() {
        pinView.didFinishCallback = didFinishEnteringPin(code:)
        pinView.didChangeCallback = { [weak self] _ in
            self?.hideErrorView()
        }
    }

    func didFinishEnteringPin(code: String) {
        if verificationDelegate?.validate(
            verificationCode: code
        ) == CredentialsValidationState.valid {
            loadingDelegate?.show(with: "verification_loading_login_text".localized(bundle: Bundle.login))
            resendButton.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + tobiAnimationDuration) {[weak self] in
                guard let self = self else { return }
                self.verificationDelegate?.verify(
                    verificationCode: code) { result, errorMessage in
                    switch result {
                    case .success(let userData):
                        self.delegate?.verificationCodeCompletion(result: .success(userData: userData))
                        UserDefaults.standard.msisdn = self.phoneNumber ?? ""
                    case .fail(let error):
                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + self.animationsDuration) {
                            let verificationError =
                                errorMessage ?? "verification_error_code_is_not_correct".localized(bundle: .login)
                            let tryAgain =
                                "upfront_login_error_try_again".localized(bundle: Bundle.login)
                            self.showErrorView(
                                errorTitle: verificationError,
                                errorSubtitle: tryAgain)
                            self.pinView.clearPin()
                            self.loadingDelegate?.hide(with: false)
                            self.resendButton.isHidden = false
                        }
                        self.delegate?.verificationCodeCompletion(result: .fail(error: error))
                    }
                }
            }
        }
    }
}

// MARK: internal methods
extension VFGLoginVerification {
    func setupUI() {
        codeVerifiedMessageView.isHidden = true
        resendButton.isHidden = true
        setupVerifyingLabel()
        startResendButtonTimer()
        setupDetailsLabels()
    }
    private func setupAccessibilityIds() {
        phoneNumberLbl.accessibilityIdentifier = "loginPhoneNumberLabel"
        changeNumberButton.accessibilityIdentifier = "loginChangeNumberButton"
    }

    func setupResendButton(countDownValue: String = "") {
        var buttonTitle = "verification_resend_login_code_text".localized(bundle: Bundle.login)
        let regEx = "^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]"
        codeVerifiedMessageView.isHidden = true
        resendButton.isHidden = false
        var attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.vodafoneRegular(16),
            .foregroundColor: UIColor.VFGLinkText
        ]
        if !countDownValue.isEmpty &&
            (countDownValue.range(of: regEx, options: .regularExpression) != nil) {
                resendButton.isEnabled = false
            attributes = [
                .font: UIFont.vodafoneRegular(16),
                .foregroundColor: UIColor.VFGSecondaryButtonOutline
            ]
                buttonTitle.append(" (\(countDownValue))")
        } else {
            resendButton.isEnabled = true
        }
        let attributeString = NSMutableAttributedString(
            string: buttonTitle,
            attributes: attributes)
        UIView.performWithoutAnimation {[weak self] in
            guard let self = self else { return }
            self.resendButton.setAttributedTitle(attributeString, for: .normal)
            self.resendButton.layoutIfNeeded()
        }
    }

    func setupDetailsLabels() {
        detailsSubTitle.text = "verification_sent_code_text".localized(bundle: Bundle.login)
        phoneNumberLbl.text = phoneNumber
        pinDetails.text = "verification_enter_code_text".localized(bundle: Bundle.login)
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.vodafoneRegular(16),
            .foregroundColor: UIColor.VFGLinkText
        ]
        let attributeString =
            NSMutableAttributedString(
                string: delegate?.changeButtonTitle ?? "",
                attributes: yourAttributes)
        changeNumberButton.setAttributedTitle(attributeString, for: .normal)
    }

    func setupVerifyingLabel() {
        verifyingLabel.font = .vodafoneLite(25)
        verifyingLabel.textColor = .VFGPrimaryText
        verifyingLabel.text = "verification_verifying_login_code_text".localized(bundle: Bundle.login)
    }

    func showErrorView(errorTitle: String, errorSubtitle: String) {
        loginErrorMessageDelegate?.showErrorMessageView(title: errorTitle)
        loginErrorMessageDelegate?
            .setupAccessibilityIdentifier(titleId: MessageAccessibilityIds.errorMassageViewTitle.rawValue)
        pinView.setErrorState(hasError: true)
    }

    func hideErrorView() {
        loginErrorMessageDelegate?.hideErrorMessageView()
        pinView.setErrorState(hasError: false)
    }
}
