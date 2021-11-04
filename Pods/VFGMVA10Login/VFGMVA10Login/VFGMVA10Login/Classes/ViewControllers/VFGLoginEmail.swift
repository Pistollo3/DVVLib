//
//  VFGEmailLoginViewController.swift
//  VFGLogin
//
//  Created by Mohamed Abd ElNasser on 7/10/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation

public enum UpfrontLoginType {
    case `default`
    case grantSecureAccess
}

/// Upfront login view controller
class VFGLoginEmail: UIViewController {
    @IBOutlet weak var rememberMeLabel: VFGLabel!
    @IBOutlet weak var forgetPasswordButton: VFGButton!
    @IBOutlet weak var loginButton: VFGButton!
    @IBOutlet weak var rememberMeToggle: VFGButton!
    @IBOutlet weak var emailTextField: VFGTextField!
    @IBOutlet weak var passwordTextField: VFGTextField!
    @IBOutlet weak var biometricLoginButton: VFGButton!
    @IBOutlet weak var biometricTypeImageView: VFGImageView!
    @IBOutlet weak var biometricStackView: UIStackView!
    @IBOutlet weak var biometricStackViewHightConstraint: NSLayoutConstraint!

    var buttonToggledOn = true
    var isErrorMessageShown = true
    var showPasswordInsights = false
    var validationTimer = Timer()
    var showPasswordIcon = true {
        didSet {
            if showPasswordIcon {
                passwordTextField.showRightIcon()
            } else {
                passwordTextField.hideRightIcon()
            }
        }
    }

    var validationDelay: TimeInterval = 0.8
    let biometricStackViewHightConstant: CGFloat = 25
    var biometricManager = BiometricManager()

    weak var upfrontLoginDelegate: VFGUpfrontLoginProtocol?
    weak var loginManagerDelegate: VFGUpfrontLoginInternalProtocol?
    weak var loginManagerNavigationDelegate: VFGLoginManagerNavigationProtocol?
    weak var loginErrorMessageDelegate: VFGLoginHandleErrorMessageProtocol?
    weak var loginHandleBlockingViewDelegate: VFGLoginHandleBlockingViewProtocol?
    weak var loadingDelegate: VFGShowHideLoadingLogoProtocol?

    enum UpfrontLoginError: Error {
        case invalid
        case blocked
    }

    fileprivate func setupEmailAccessibilityIds() {
        passwordTextField.setTextFieldIdentifier(with: EmailAccessibilityIds.passwordTextFieldId.rawValue)
        passwordTextField.setRightButtonIdentifier(with: EmailAccessibilityIds.rightButtonIdentifierPassword)
        emailTextField.setTextFieldIdentifier(with: EmailAccessibilityIds.emailTextFieldId.rawValue)
        emailTextField.setRightButtonIdentifier(with: EmailAccessibilityIds.rightButtonIdentifierEmail)
        emailTextField.setErrorHintLabelIdentifier(with: EmailAccessibilityIds.errorHintLabelIdentifier.rawValue)
        rememberMeToggle.accessibilityIdentifier = EmailAccessibilityIds.rememberMeToggleId.rawValue
        forgetPasswordButton.accessibilityIdentifier = EmailAccessibilityIds.forgetPasswordButtonId.rawValue
        loginButton.accessibilityIdentifier = EmailAccessibilityIds.loginButtonId.rawValue
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        passwordTextField.delegate = self
        emailTextField.delegate = self
        setupEmailAccessibilityIds()
        let (username, password) = retrieveCredentialsFromKeychain()
        setupBiometricLoginUI(username: username, password: password)
    }

    func configureUI() {
        rememberMeLabel.font = .vodafoneRegular(15)
        rememberMeLabel.textColor = .VFGPrimaryText

        forgetPasswordButton.titleLabel?.font = .vodafoneRegular(15)
        forgetPasswordButton.setTitleColor(.VFGPrimaryText, for: .normal)

        rememberMeToggle.setImage(
            upfrontLoginDelegate?.isRememberMeEnabled ?? false ?
                UIImage.VFGToggle.Small.active: UIImage.VFGToggle.Small.inactive, for: .normal)
        buttonToggledOn = false

        loginButton.isEnabled = false

        showPasswordIcon = true

        setupTexts()

        biometricStackView.isHidden = !VFGLoginManager.isBiometricEnabled
        biometricStackViewHightConstraint.constant = VFGLoginManager.isBiometricEnabled
            ? biometricStackViewHightConstant : 0

        emailTextField.resetTextField()
        passwordTextField.resetTextField()
        let firstVcAsEmail = (navigationController?.viewControllers.first as? VFGLoginEmail)
        navigationController?.navigationBar.isHidden = (firstVcAsEmail != nil)
    }

    func setupTexts() {
        rememberMeLabel.text = "upfront_remember_me_label".localized(bundle: Bundle.login)
        let forgotPassword = "upfront_forgot_your_password_label".localized(bundle: Bundle.login)
        forgetPasswordButton.setUnderlinedTitle(
            title: forgotPassword,
            font: .vodafoneRegular(14),
            color: .VFGPrimaryText,
            state: .normal)
        loginButton.setTitle("upfront_login_text".localized(bundle: Bundle.login), for: .normal)
        let hint = "upfront_email_or_phone_number_hint".localized(bundle: Bundle.login)
        let secondaryPlaceHolder = "upfront_email_or_phone_number_secondary_placeholder".localized(
            bundle: Bundle.login)
        emailTextField.configureTextField(
            topTitleText: hint,
            placeHolder: hint,
            secondaryPlaceholder: secondaryPlaceHolder,
            isSecondaryPlaceholderEnabled: upfrontLoginDelegate?.isSecondaryPlaceholderEnabled,
            rightIcon: nil,
            textContentType: .username)
        emailTextField.notAllowedCharacters = upfrontLoginDelegate?.mailNotAllowedCharacters
        emailTextField.maxLength = upfrontLoginDelegate?.mailLengthRange.upperBound

        passwordTextField.configureTextField(
            topTitleText: "upfront_password_hint".localized(bundle: Bundle.login),
            placeHolder: "upfront_password_hint".localized(bundle: Bundle.login),
            rightIcon: UIImage.VFGPassword.show,
            secureTextEntry: true,
            textContentType: .password)
        emailTextField.textFieldKeyboardType = upfrontLoginDelegate?.emailOrPhoneKeyboardType ?? .emailAddress
        passwordTextField.textFieldKeyboardType = upfrontLoginDelegate?.passwordKeyboardType ?? .emailAddress
        passwordTextField.maxLength = upfrontLoginDelegate?.passwordLengthRange.upperBound
    }

    func showErrorMessage(title: String) {
        isErrorMessageShown = true
        loginErrorMessageDelegate?.showErrorMessageView(title: title)
        loginErrorMessageDelegate?
            .setupAccessibilityIdentifier(titleId: EmailAccessibilityIds.errorMassageViewTitle.rawValue)
        emailTextField.showError(borderState: .normal)
        passwordTextField.showError(borderState: .normal)
    }

    func hideErrorMessage() {
        isErrorMessageShown = false
        loginErrorMessageDelegate?.hideErrorMessageView()
    }

    func backToFullState() {
        loginErrorMessageDelegate?.hideErrorMessageView()
        if !passwordTextField.textFieldText.isEmpty {
            passwordTextField.backToFullState()
        }
        if !emailTextField.textFieldText.isEmpty {
            emailTextField.backToFullState()
        }
    }

    func hideAllErrorMessages() {
        hideErrorMessage()
        emailTextField.hideError()
        passwordTextField.hideError()
    }

    func loginCompletion(
        userName: String? = nil,
        password: String? = nil
    ) -> (VFGLoginResult, String?) -> Void {
        return { [weak self] result, errorMessageTitle in
            guard let self = self else { return }
            switch result {
            case .success(let userData):
                self.loadingDelegate?.hide(with: true)
                self.hideAllErrorMessages()
                if self.upfrontLoginDelegate is VFGLoginOTPDelegate {
                    self.sendVerificationCode()
                } else {
                    self.loginManagerDelegate?.upFrontCompletion(result: .success(userData: userData))
                }
                guard let userName = userName, let password = password else {
                    return
                }
                self.saveCredentialsToKeychain(userName: userName, password: password)
            case .fail(let error):
                self.loadingDelegate?.hide(with: false)
                self.handleLoginCompletionFail(
                    error: error,
                    errorMessageTitle: errorMessageTitle
                )
            }
        }
    }

    func handleLoginCompletionFail(error: Error?, errorMessageTitle: String?) {
        switch error as? CredentialsValidationState {
        case .invalidFormat:
            self.hideErrorMessage()
            self.emailTextField
                .showError(title: "upfront_login_error_enter_valid_email".localized(bundle: Bundle.login))
            self.passwordTextField.showError()
            self.loginManagerDelegate?.upFrontCompletion(result: .fail(error: UpfrontLoginError.invalid))
        case .limitedTrials, .invalid:
            self.emailTextField.hideError()
            self.passwordTextField.hideError()
            self.showErrorMessage(title: errorMessageTitle ?? "")
        case .blocked:
            self.loginHandleBlockingViewDelegate?.addBlockingView(
                userEmail: self.emailTextField.textFieldText)
            self.loginManagerDelegate?.upFrontCompletion(result: .fail(error: UpfrontLoginError.blocked))
        default:
            break
        }
    }

    @IBAction func login(_ sender: VFGButton) {
        let completion: (VFGLoginResult, String?) -> Void
        let emailOrPhone = emailTextField.textFieldText
        let password = passwordTextField.textFieldText
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

    @IBAction func biometricLoginDidPress(_ sender: Any) {
        let (username, password) = retrieveCredentialsFromKeychain()
        authenticateDeviceOwner(username: username, password: password) { error in
            if error == nil {
                self.upfrontLoginDelegate?.biometricLoginButtonDidPress {
                    self.authenticateBiometricLogin()
                }
            }
        }
    }

    @IBAction func forgetPasswordDidPress(_ sender: VFGButton) {
        upfrontLoginDelegate?.forgetPasswordButtonDidPress { viewController in
            loginManagerNavigationDelegate?.navigate(to: viewController)
        }
    }
    @IBAction func rememberMeToggleClicked(_ sender: Any) {
        if buttonToggledOn {
            rememberMeToggle.setImage(UIImage.VFGToggle.Small.inactive, for: .normal)
            buttonToggledOn = false
        } else {
            rememberMeToggle.setImage(UIImage.VFGToggle.Small.active, for: .normal)
            buttonToggledOn = true
        }
    }
}

extension VFGLoginEmail {
    func sendVerificationCode() {
        guard let verificationUpfrontLogin = upfrontLoginDelegate as? VFGLoginOTPDelegate else { return }
        verificationUpfrontLogin.sendVerificationCode(
            emailOrPhone: self.emailTextField.textFieldText
        ) { [weak self] result, errorMessageTitle in
            guard let self = self else { return }
            switch result {
            case .success:
                self.loadingDelegate?.hide(with: true)
                self.loginManagerNavigationDelegate?
                    .navigateToLoginOTP(
                        emailOrPhone: self.emailTextField.textFieldText,
                        completionDelegate: self
                    )
            case .fail:
                self.loadingDelegate?.hide(with: false)
                self.showErrorMessage(title: errorMessageTitle ?? "")
            }
            self.loginButton.isUserInteractionEnabled = true
        }
    }

    func registerNow() {
        upfrontLoginDelegate?.registerNowButtonDidPress { viewController in
            loginManagerNavigationDelegate?.navigate(to: viewController)
        }
    }

    func resetAccount() {
        upfrontLoginDelegate?.resetAccountButtonDidPress { viewController in
            loginManagerNavigationDelegate?.navigate(to: viewController)
        }
    }
}

extension VFGLoginEmail: VFGLoginOTPInternalProtocol {
    var changeButtonTitle: String {
        "verification_change_email_text".localized(bundle: Bundle.login)
    }

    func verificationCodeCompletion(result: VFGLoginResult) {
        loginManagerDelegate?.upFrontCompletion(result: result)
    }

    func changeButtonDidPress() {
        guard let parentVC = self.parent as? VFGLoginBaseViewController else {
            return
        }
        if parentVC.isLoginVerificationPresented {
            parentVC.presentEmailLoginViewController()
            parentVC.upfrontLoginObj?.backToFullState()
        }
    }

    func resendButtonDidPress() {
        guard let verificationUpfrontLogin = upfrontLoginDelegate as? VFGLoginOTPDelegate else { return }
        verificationUpfrontLogin.sendVerificationCode(
            emailOrPhone: emailTextField.textFieldText,
            completion: nil
        )
    }
}
