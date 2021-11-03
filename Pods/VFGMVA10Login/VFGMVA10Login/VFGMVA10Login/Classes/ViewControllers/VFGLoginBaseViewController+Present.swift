//
//  VFGLoginBaseViewController+Present.swift
//  VFGMVA10Login
//
//  Created by Hussien Gamal Mohammed Fahmy on 15/04/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import VFGMVA10Foundation

extension VFGLoginBaseViewController {
    func present(screenType: VFGLoginScreensType) {
        switch screenType {
        case .soft where softLoginImplementation != nil:
            presentPhoneLoginViewController()
        case .upfront where upfrontLoginImplementation != nil:
            presentEmailLoginViewController()
        case .fixedLine where fixedLineUpfrontLoginProtocol != nil:
            presentFixedLineUpfrontLogin()
        case .chooseAccount where fixedLineUpfrontLoginProtocol != nil:
            presentChooseAccountType()
        case .accountsList where accountsListLoginImplementation != nil:
            presentAccountsListViewController()
        default:
            break
        }
    }

    func presentPhoneLoginViewController(shouldAnimate: Bool = true) {
        verificationOTPImplementation = softLoginImplementation
        let isUpFrontLoginEnabled = (upfrontLoginImplementation != nil)
        let actionButtonTwoTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.vodafoneRegular(16),
            .foregroundColor: UIColor.VFGWhiteText,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let actionButtonTwoTitle =
            NSMutableAttributedString(
                string: "soft_login_footer_second_label".localized(bundle: Bundle.login),
                attributes: actionButtonTwoTextAttributes)
        actionButtonTwo.setAttributedTitle(actionButtonTwoTitle, for: .normal)
        actionButtonOne.setTitle("soft_login_footer_first_label".localized(bundle: Bundle.login), for: .normal)
        setupAccessibilityIds(
            actionButtonOneId: BaseAccessibilityIds.actionButtonOneForPhoneLogin.rawValue,
            actionButtonTwoId: BaseAccessibilityIds.actionButtonTwoForPhoneLogin.rawValue)
        toggleRegisterNowVisibility(isHidden: !isUpFrontLoginEnabled)
        containerScrollView.isScrollEnabled = true
        // presentViewController
        VFGLoginManager.trackView(screenType: .soft)
        hideErrorMessageView()
        showTitleLabel()
        toggleFooterVisibility(isHidden: true)
        adjustLoginCardViewTopConstraint()
        loginPhoneObj?.loadViewIfNeeded()
        view.layoutIfNeeded()

        let viewToHide = presentedView()
        if shouldAnimate {
            showAndHideViewsWithAnimation(
                viewToHide: viewToHide,
                viewToShow: loginPhoneObj?.view)
        } else {
            viewToHide?.isHidden = true
            loginPhoneObj?.view.isHidden = false
        }
        saveWhichViewIsPresented(isPhoneLoginPresented: true)
    }

    fileprivate func setupAccessibilityIds(actionButtonOneId: String, actionButtonTwoId: String) {
        actionButtonOne.accessibilityIdentifier = actionButtonOneId
        actionButtonTwo.accessibilityIdentifier = actionButtonTwoId
    }

    func presentEmailLoginViewController() {
        guard let upfrontLoginImplementation = upfrontLoginImplementation else {
            return
        }

        if let upfrontOTPDelegate = upfrontLoginImplementation as? VFGLoginOTPDelegate {
            verificationOTPImplementation = upfrontOTPDelegate
        }

        setupAccessibilityIds(
            actionButtonOneId: BaseAccessibilityIds.actionButtonOneForEmailLogin.rawValue,
            actionButtonTwoId: BaseAccessibilityIds.actionButtonTwoForEmailLogin.rawValue)
        actionButtonOne.titleLabel?.font = .vodafoneRegular(17)
        actionButtonOne.setTitle(
            "registered_account_want_to_register_label".localized(
                bundle: Bundle.login),
            for: .normal)
        if upfrontLoginImplementation.loginType == .grantSecureAccess {
            closeButton.isHidden = false
            subtitleLabel.isHidden = false
            subtitleLabel.text = "upfront_login_access_secure_content_subtitle".localized(bundle: .login)
        }
        toggleFooterVisibility(isHidden: false)
        backButton.isHidden = fixedLineUpfrontLoginProtocol == nil
        containerScrollView.isScrollEnabled = true
        actionButtonTwo.setUnderlinedTitle(
            title: "upfront_register_now_label".localized(bundle: .login),
            font: .vodafoneRegular(17),
            color: .VFGWhiteText,
            state: .normal)
        toggleRegisterNowVisibility(isHidden: !(upfrontLoginImplementation.isRegistrationEnabled))
        VFGLoginManager.trackView(screenType: .upfront)
        hideErrorMessageView()
        showTitleLabel()
        adjustLoginCardViewTopConstraint()
        upfrontLoginObj?.loadViewIfNeeded()
        view.layoutIfNeeded()

        showAndHideViewsWithAnimation(
            viewToHide: presentedView(),
            viewToShow: upfrontLoginObj?.view)
        saveWhichViewIsPresented(isEmailLoginPresented: true)
        authenticateBiometricLogin(upfrontLogin: upfrontLoginObj)
    }

    func authenticateBiometricLogin(upfrontLogin: VFGLoginEmail?) {
        let (username, password) = upfrontLogin?.retrieveCredentialsFromKeychain() ?? ("", "")
        upfrontLogin?.authenticateDeviceOwner(username: username, password: password) { error in
            if error == nil {
                upfrontLogin?.upfrontLoginDelegate?.authenticateBiometricLogin {
                    upfrontLogin?.authenticateBiometricLogin()
                }
            }
        }
    }

    func presentLoginVerificationViewController(
        emailOrPhone: String,
        completionDelegate: VFGLoginOTPInternalProtocol?
    ) {
        loginVerification?.phoneNumber = emailOrPhone
        loginVerification?.delegate = completionDelegate
        loginVerification?.viewDidLoad()
        VFGLoginManager.trackView(screenType: .verificationCode)
        loginVerification?.pinView.becomeFirstResponderAtIndex = 0
        loginVerification?.pinView.refreshView()
        hideErrorMessageView()
        showTitleLabel()
        closeButton.isHidden = true
        containerScrollView.isScrollEnabled = true
        toggleFooterVisibility(isHidden: true)
        adjustLoginCardViewTopConstraint()

        showAndHideViewsWithAnimation(
            viewToHide: loadingLogoView,
            viewToShow: loginVerification?.view)
        saveWhichViewIsPresented(isLoginVerificationPresented: true)
    }

    func presentAccountsListViewController() {
        actionButtonOne.titleLabel?.font = .vodafoneRegular(17)
        actionButtonOne.setTitle(
            "registered_account_want_to_register_label".localized(
                bundle: Bundle.login),
            for: .normal)
        actionButtonTwo.setUnderlinedTitle(
            title: "upfront_register_now_label".localized(
                bundle: Bundle.login),
            font: .vodafoneRegular(17),
            color: .VFGWhiteText,
            state: .normal)
        toggleRegisterNowVisibility(isHidden: !(fixedLineUpfrontLoginProtocol?.isRegistrationEnabled ?? true))
        closeButton.isHidden = accountsListLoginImplementation?.isCloseButtonHidden ?? true
        loginAccountsList?.viewDidLoad()
        VFGLoginManager.trackView(screenType: .accountsList)
        hideErrorMessageView()
        titleLabel.isHidden = false
        titleLabel.bounds.size.height = titleLabelHeight
        containerScrollView.isScrollEnabled = false
        backButton.isHidden = true
        toggleFooterVisibility(isHidden: true)
        adjustLoginCardViewTopConstraint()
        view.layoutIfNeeded()
        titleLabel.text = "registered_account_sign_in_label".localized(bundle: Bundle.login)
        showAndHideViewsWithAnimation(
            viewToHide: presentedView(),
            viewToShow: loginAccountsList?.view)
        saveWhichViewIsPresented(isAccountsListPresented: true)
    }

    func presentChooseAccountType() {
        guard let accountsList = accountsListLoginImplementation else {
            return
        }
        let accountsRetrieved = accountsList.retrieveSavedAccounts()
        closeButton.isHidden = accountsList.isCloseButtonHidden
        actionButtonOne.titleLabel?.font = .vodafoneRegular(17)
        actionButtonOne.setTitle(
            "upfront_not_registered_with_my_vodafone_label".localized(
                bundle: Bundle.login),
            for: .normal)

        actionButtonTwo.setUnderlinedTitle(
            title: "upfront_register_now_label".localized(
                bundle: Bundle.login),
            font: .vodafoneRegular(17),
            color: .VFGWhiteText,
            state: .normal)
        toggleRegisterNowVisibility(isHidden: !(fixedLineUpfrontLoginProtocol?.isRegistrationEnabled ?? true))
        chooseAccountView?.viewDidLoad()
        VFGLoginManager.trackView(screenType: .chooseAccount)
        chooseAccountView?.isSignInButtonHidden = accountsRetrieved.isEmpty
        hideErrorMessageView()
        titleLabel.isHidden = true
        titleLabel.bounds.size.height = 0
        backButton.isHidden = true
        containerScrollView.isScrollEnabled = true
        toggleFooterVisibility(isHidden: true)
        adjustLoginCardViewTopConstraint()
        view.layoutIfNeeded()
        showAndHideViewsWithAnimation(
            viewToHide: presentedView(),
            viewToShow: chooseAccountView?.view)
        saveWhichViewIsPresented(isChooseAccountPresented: true)
    }

    func presentFixedLineUpfrontLogin() {
        if let fixedLineUpfrontOTPDelegate = fixedLineUpfrontLoginProtocol as? VFGLoginOTPDelegate {
            verificationOTPImplementation = fixedLineUpfrontOTPDelegate
        }
        guard let accountsRetrieved = accountsListLoginImplementation?.retrieveSavedAccounts() else {
            return
        }
        actionButtonOne.titleLabel?.font = .vodafoneRegular(17)
        actionButtonOne.setTitle(
            "upfront_not_registered_with_my_vodafone_label".localized(
                bundle: Bundle.login),
            for: .normal)

        actionButtonTwo.setUnderlinedTitle(
            title: "upfront_register_now_label".localized(
                bundle: Bundle.login),
            font: .vodafoneRegular(17),
            color: .VFGWhiteText,
            state: .normal)
        toggleRegisterNowVisibility(isHidden: !(fixedLineUpfrontLoginProtocol?.isRegistrationEnabled ?? true))
        fixedLineLoginObj?.loadViewIfNeeded()
        fixedLineUpfrontLoginProtocol?.viewDidLoad()
        VFGLoginManager.trackView(screenType: .fixedLine)
        fixedLineLoginObj?.isSignInButtonHidden = accountsRetrieved.isEmpty
        hideErrorMessageView()
        if !titleLabel.isHidden {
            titleLabel.isHidden = true
            titleLabel.bounds.size.height = 0
        }
        backButton.isHidden = false
        closeButton.isHidden = true
        containerScrollView.isScrollEnabled = true
        toggleFooterVisibility(isHidden: true)
        adjustLoginCardViewTopConstraint()
        view.layoutIfNeeded()
        showAndHideViewsWithAnimation(
            viewToHide: presentedView(),
            viewToShow: fixedLineLoginObj?.view)
        saveWhichViewIsPresented(isFixedLineUpfrontLoginPresented: true)
    }

    func showTitleLabel() {
        titleLabel.isHidden = false
        titleLabel.bounds.size.height = titleLabelHeight
        titleLabel.text = upfrontLoginImplementation?.loginType == .grantSecureAccess
            ? "upfront_login_access_secure_content_title".localized(bundle: .login)
            : "login_title_text".localized(bundle: Bundle.login)
    }

    func adjustLoginCardViewTopConstraint() {
        let topConstraint = cardView.frame.minY
        let middleConstraint = actionButtonTwo.frame.maxY
        let bottomConstraint = languageStackView.frame.maxY
        let middleHeight = (middleConstraint - topConstraint) + tobiHalfHeight
        let bottomHeight = (bottomConstraint - topConstraint) + tobiHalfHeight
        let contentHeight = languageStackView.isHidden ? middleHeight : bottomHeight
        let remainingSpace = view.frame.height - contentHeight
        let topHeight = remainingSpace / 2

        if view.frame.height > contentHeight {
            if topHeight > topConstraintMinHeight {
                loginCardViewTopConstraint.constant = languageStackView.isHidden
                    ? topHeight
                    : upfrontTopConstraintMinHeight
            } else {
                loginCardViewTopConstraint.constant = topConstraintMinHeight
            }
        } else {
            loginCardViewTopConstraint.constant = topConstraintMinHeight
        }
    }

    func toggleFooterVisibility(isHidden: Bool) {
        moreInformationStackView.isHidden = isHidden
        separatorView.isHidden = isHidden
        languageStackView.isHidden = isHidden
    }

    func toggleRegisterNowVisibility(isHidden: Bool) {
        actionButtonOne.isHidden = isHidden
        actionButtonTwo.isHidden = isHidden
    }
}
