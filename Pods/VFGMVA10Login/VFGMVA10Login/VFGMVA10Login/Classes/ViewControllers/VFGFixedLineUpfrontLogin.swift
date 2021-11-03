//
//  VFGFixedLineUpfrontLogin.swift
//  VFGMVA10Login
//
//  Created by Hamsa Hassan on 4/8/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation

class VFGFixedLineUpfrontLogin: UIViewController {
    @IBOutlet weak var mainTitleLabel: VFGLabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var loginPersonalType: VFGButton!
    @IBOutlet weak var loginBusinessType: VFGButton!
    @IBOutlet weak var slidingViewLeading: NSLayoutConstraint!
    @IBOutlet weak var slidingView: UIView!
    @IBOutlet weak var userNameTextField: VFGTextField!
    @IBOutlet weak var passwordTextField: VFGTextField!
    @IBOutlet weak var rememberMeToggle: VFGButton!
    @IBOutlet weak var rememberMeLabel: VFGLabel!
    @IBOutlet weak var forgotPasswordButton: VFGButton!
    @IBOutlet weak var nextButton: VFGButton!
    @IBOutlet weak var signInButton: VFGButton!
    @IBOutlet weak var signInButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var errorMessageView: UIView!
    @IBOutlet weak var errorMessageSeperator: UIView!
    @IBOutlet weak var errorMessageDescription: VFGLabel!
    let userNameHint = "custom_upfront_username_hint".localized(bundle: Bundle.login)
    let userNameSecondaryPlaceHolder = "custom_upfront_username_secondary_placeholder".localized(
        bundle: Bundle.login)
    let businessUserNameHint = "custom_upfront_username_business_hint".localized(bundle: Bundle.login)
    let businessSecondaryPlaceHolder = "custom_upfront_username_business_secondary_placeholder".localized(
        bundle: Bundle.login)

    var buttonHeight: CGFloat = 42
    var isButtonToggledOn = false
    var isErrorMessageShown = true
    var isPersonal = true
    var validationTimer = Timer()
    var passwordInsightIsHidden = true
    var passwordIconIsHidden = false {
        didSet {
            if passwordIconIsHidden {
                passwordTextField.hideRightIcon()
            } else {
                passwordTextField.showRightIcon()
            }
        }
    }
    var isSignInButtonHidden = false {
        didSet {
            signInButton.isHidden = isSignInButtonHidden
            signInButtonHeightConstraint.constant = isSignInButtonHidden ? 0 : buttonHeight
        }
    }
    static let storyBoardName = "VFGFixedLineUpfrontLogin"
    var validationDelay: TimeInterval = 0.8
    weak var fixedLineUpfrontLoginDelegate: VFGFixedLineUpfrontLoginProtocol?
    weak var loginManagerNavigationDelegate: VFGLoginManagerNavigationProtocol?
    weak var loginErrorMessageDelegate: VFGLoginHandleErrorMessageProtocol?
    weak var loginManagerDelegate: VFGFixedLineUpfrontLoginInternalProtocol?
    weak var loadingDelegate: VFGShowHideLoadingLogoProtocol?
    weak var loginHandleBlockingViewDelegate: VFGLoginHandleBlockingViewProtocol?
    weak var loginAccountListsDelegate: VFGLoginAccountsListProtocol?

    enum FixedLineUpfrontLoginError: Error {
        case invalid
        case blocked
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocalization()
    }

    func setupUI() {
        rememberMeToggle.setImage(UIImage.VFGToggle.Small.inactive, for: .normal)
        isButtonToggledOn = false
        userNameTextField.configureTextField(
            topTitleText: userNameHint,
            placeHolder: userNameHint,
            secondaryPlaceholder: userNameSecondaryPlaceHolder,
            isSecondaryPlaceholderEnabled: fixedLineUpfrontLoginDelegate?.isSecondaryPlaceholderEnabled,
            rightIcon: nil)
        userNameTextField.delegate = self

        let passwordHint = "custom_upfront_password_hint".localized(bundle: Bundle.login)
        passwordTextField.configureTextField(
            topTitleText: passwordHint,
            placeHolder: passwordHint,
            rightIcon: UIImage.VFGPassword.show,
            secureTextEntry: true)
        passwordTextField.delegate = self

        let forgotPassword = "custom_upfront_forgot_your_password_label".localized(bundle: Bundle.login)
        forgotPasswordButton.setUnderlinedTitle(
            title: forgotPassword,
            font: .vodafoneRegular(14),
            color: .VFGSecondaryText,
            state: .normal)
        nextButton.isEnabled = false
        loginPersonalType.titleLabel?.font = .vodafoneBold(17)
        slidingViewLeading.constant = 0

        userNameTextField.textFieldKeyboardType = fixedLineUpfrontLoginDelegate?.userNameKeyboardType ?? .emailAddress
        userNameTextField.maxLength = fixedLineUpfrontLoginDelegate?.usernameLengthRange.upperBound


        passwordTextField.textFieldKeyboardType = fixedLineUpfrontLoginDelegate?.passwordKeyboardType ?? .emailAddress
        passwordTextField.maxLength = fixedLineUpfrontLoginDelegate?.passwordLengthRange.upperBound
        setupErrorView()
    }

    func setupErrorView() {
        errorMessageView.isHidden = true
        errorMessageSeperator.isHidden = true
        errorMessageView.layer.borderWidth = 1
        errorMessageView.layer.borderColor = UIColor.VFGAlertError.cgColor
        errorMessageView.layer.cornerRadius = 6
        errorMessageView.clipsToBounds = true
        errorMessageDescription.font = .vodafoneRegular(16)
        errorMessageDescription.textColor = .VFGPrimaryText
    }

    func showFixedLineErrorMessage(title: String) {
        errorMessageView.isHidden = false
        errorMessageSeperator.isHidden = false
        errorMessageDescription.text = title
    }

    func hideFixedLineErrorMessage() {
        errorMessageView.isHidden = true
        errorMessageSeperator.isHidden = true
    }

    func setupLocalization() {
        mainTitleLabel.text = "custom_upfront_log_in_to".localized(bundle: Bundle.login)
        loginPersonalType.setTitle("custom_upfront_account_type_personal".localized(bundle: Bundle.login), for: .normal)
        loginBusinessType.setTitle("custom_upfront_account_type_business".localized(bundle: Bundle.login), for: .normal)
        rememberMeLabel.text = "custom_upfront_remember_me".localized(bundle: Bundle.login)
        nextButton.setTitle("custom_upfront_next".localized(bundle: Bundle.login), for: .normal)
        signInButton.setTitle(
            "custom_upfront_saved_account".localized(bundle: Bundle.login),
            for: .normal
        )
    }

    @IBAction func loginPersonalTypeAction(_ sender: Any) {
        VFGLoginManager.trackEvent(
            screenType: .fixedLine,
            eventLabel: "Personal")
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.slidingViewLeading?.constant = self.loginPersonalType.frame.minX
            self.view.layoutIfNeeded()
        }
        isPersonal = true
        loginPersonalType.titleLabel?.font = .vodafoneBold(17)
        loginBusinessType.titleLabel?.font = .vodafoneRegular(17)
        userNameTextField.textFieldTopTitleText = userNameHint
        userNameTextField.textFieldSecondaryPlaceholderText = userNameSecondaryPlaceHolder
        userNameTextField.textFieldPlaceHolderText = userNameHint
    }

    @IBAction func loginBusinessTypeAction(_ sender: Any) {
        VFGLoginManager.trackEvent(
            screenType: .fixedLine,
            eventLabel: "Business")
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.slidingViewLeading?.constant = self.loginBusinessType.frame.minX
            self.view.layoutIfNeeded()
        }
        isPersonal = false
        loginBusinessType.titleLabel?.font = .vodafoneBold(17)
        loginPersonalType.titleLabel?.font = .vodafoneRegular(17)
        userNameTextField.textFieldTopTitleText = businessUserNameHint
        userNameTextField.textFieldSecondaryPlaceholderText = businessSecondaryPlaceHolder
        userNameTextField.textFieldPlaceHolderText = businessUserNameHint
    }

    @IBAction func forgotPasswordAction(_ sender: Any) {
        fixedLineUpfrontLoginDelegate?.forgetPasswordButtonDidPress { viewController in
            loginManagerNavigationDelegate?.navigate(to: viewController)
        }
    }

    @IBAction func nextButtonDidPress(_ sender: Any) {
        let completion: (VFGLoginResult, String?) -> Void = buildCompletion()
        let usernameOrPhone = userNameTextField.textFieldText
        let password = passwordTextField.textFieldText
        validationTimer.invalidate()
        loginErrorMessageDelegate?.hideErrorMessageView()
        fixedLineUpfrontLoginDelegate?.loginButtonDidPress { [weak self] in
            guard let self = self else { return }
            self.loadingDelegate?.show(with: "verification_loading_login_text".localized(bundle: Bundle.login))
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                guard let self = self else { return }
                self.fixedLineUpfrontLoginDelegate?.login(
                    emailOrPhone: usernameOrPhone,
                    password: password,
                    isPersonal: self.isPersonal,
                    rememberMe: self.isButtonToggledOn,
                    completion: completion)
            }
            self.nextButton.isEnabled = true
        }
    }

    @IBAction func signInToSavedAccountAction(_ sender: Any) {
        loginManagerNavigationDelegate?.navigateToSavedAccounts()
    }

    @IBAction func rememberMeToggleAction(_ sender: Any) {
        if isButtonToggledOn {
            rememberMeToggle?.setImage(UIImage.VFGToggle.Small.inactive, for: .normal)
            isButtonToggledOn = false
        } else {
            rememberMeToggle?.setImage(UIImage.VFGToggle.Small.active, for: .normal)
            isButtonToggledOn = true
        }
    }

    func showErrorMessage(title: String) {
        isErrorMessageShown = true
        loginErrorMessageDelegate?.showErrorMessageView(title: title)
        userNameTextField.showError(borderState: .normal)
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
        if !userNameTextField.textFieldText.isEmpty {
            userNameTextField.backToFullState()
        }
    }

    func hideAllErrorMessages() {
        hideErrorMessage()
        userNameTextField.hideError()
        passwordTextField.hideError()
    }

    func registerNow() {
        fixedLineUpfrontLoginDelegate?.registerNowButtonDidPress { viewController in
            loginManagerNavigationDelegate?.navigate(to: viewController)
        }
    }

    func backButtonAction() {
        loginManagerNavigationDelegate?.navigateToChooseAccount()
    }
}
