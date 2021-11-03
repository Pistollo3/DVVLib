//
//  VFGLoginBaseViewController.swift
//  VFGLogin
//
//  Created by Esraa Eldaltony on 10/28/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import VFGMVA10Foundation
import Lottie

/// Container view controller which presents all login flows
class VFGLoginBaseViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var viewInScroll: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardViewShadow: UIView!
    @IBOutlet weak var tobiFace: VFGTOBIFace!
    @IBOutlet weak var tobiLessImageView: VFGImageView!
    @IBOutlet weak var tobiLessBackgroundView: UIView!
    @IBOutlet weak var errorMessageContainer: UIView!
    @IBOutlet weak var errorTitleLabel: VFGLabel!
    @IBOutlet weak var errorMessageSeparator: UIView!
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var keyboardHeight: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: VFGLabel!
    @IBOutlet weak var subtitleLabel: VFGLabel!
    @IBOutlet weak var actionButtonOne: VFGButton!
    @IBOutlet weak var actionButtonTwo: VFGButton!
    @IBOutlet weak var backButton: VFGButton!
    @IBOutlet weak var loginCardViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeButton: VFGButton!
    @IBOutlet weak var moreInformationStackView: UIStackView!
    @IBOutlet weak var moreInformationLabel: VFGLabel!
    @IBOutlet weak var moreInformationButton: VFGButton!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var languageStackView: UIStackView!
    @IBOutlet weak var changeLanguageButton: VFGButton!
    @IBOutlet weak var selectedLanguageLabel: VFGLabel!

    static let storyBoardName = "VFGLoginBaseStoryboard"
    var statusBar: UIView?
    var blockingView: VFGLoginBlockingView?
    var loginNavigationController: UINavigationController?
    var loginPhoneObj: VFGLoginPhoneViewController?
    var upfrontLoginObj: VFGLoginEmail?
    var loginVerification: VFGLoginVerification?
    var loadingLogoView: VFGLoadingLogoView?
    var fixedLineLoginObj: VFGFixedLineUpfrontLogin?
    var loginAccountsList: VFGLoginAccountsList?
    var chooseAccountView: VFGChooseAccountTypeViewController?
    var initialScreen: VFGLoginScreensType?

    // protocols
    var verificationOTPImplementation: VFGLoginOTPDelegate?
    var seamlessLoginImplementation: VFGSeamlessLoginProtocol?
    var upfrontLoginImplementation: VFGUpfrontLoginProtocol?
    var accountsListLoginImplementation: VFGLoginAccountsListProtocol?
    var upfrontLoginInternalProtocol: VFGUpfrontLoginInternalProtocol?
    var softLoginImplementation: VFGSoftLoginProtocol?
    var softLoginInternalProtocol: VFGSoftLoginInternalProtocol?
    var fixedLineUpfrontLoginProtocol: VFGFixedLineUpfrontLoginProtocol?
    var fixedLineupfrontLoginInternalProtocol: VFGFixedLineUpfrontLoginInternalProtocol?

    // bools
    var isPhoneLoginPresented = false
    var isLoginVerificationPresented = false
    var isEmailLoginPresented = false
    var isFixedLineUpfrontLoginPresented = false
    var isChooseAccountPresented = false
    var isAccountsListPresented = false
    var isTobiEnabled = true

    // constants
    var animationsDuration: TimeInterval = 0.3
    var topConstraintConstant: CGFloat = 16
    var titleLabelHeight: CGFloat = 24
    var topConstraintMinHeight: CGFloat = 100
    var upfrontTopConstraintMinHeight: CGFloat = 125
    var tobiHalfHeight: CGFloat = 50

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        observeKeyboardNotifications()
        addKeyboardDismissHandler()
        backgroundView.setGradientBackgroundColor(colors: UIColor.VFGBackgroundRedGradient)
        containerScrollView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        loginNavigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        containerScrollView.contentSize = CGSize(width: viewInScroll.frame.width, height: viewInScroll.frame.height)
        setupStatusBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusBar?.backgroundColor = .clear
    }
}

extension VFGLoginBaseViewController {
    // MARK: - settingUp UI
    func setupUI() {
        setupCardView()
        setupErrorView()
        setupButtons()
        setupTobiBubbleView()
        embedViewControllers()
        presentNextLoginViewController()
    }

    func setupStatusBar() {
        if #available(iOS 13.0, *) {
            statusBar = UIView(frame: UIApplication.shared.windows.first(where:) {
                $0.isKeyWindow
            }?.windowScene?.statusBarManager?.statusBarFrame ?? .zero)
            UIApplication.shared.windows.first(where:) { $0.isKeyWindow }?.addSubview(statusBar ?? UIView())
        } else {
            statusBar = UIApplication.shared.value(forKeyPath: "statusBar") as? UIView
        }
    }

    func setupCardView() {
        titleLabel.text = "login_title_text".localized(bundle: Bundle.login)
        cardViewShadow.configureShadow(
            offset: CGSize(
                width: 0,
                height: 2.0),
            radius: 8.0,
            opacity: 0.2)
        cardView.clipsToBounds = true
    }

    func setupErrorView() {
        errorMessageContainer.isHidden = true
        errorMessageSeparator.isHidden = true
        errorMessageContainer.layer.borderWidth = 1
        errorMessageContainer.layer.borderColor = UIColor.VFGAlertError.cgColor
        errorMessageContainer.layer.cornerRadius = 6
        errorMessageContainer.clipsToBounds = true

        errorTitleLabel.font = .vodafoneRegular(16)
        errorTitleLabel.textColor = .VFGPrimaryText
    }

    func setupTobiBubbleView() {
        if isTobiEnabled {
            tobiFace.isHidden = false
            tobiLessImageView.isHidden = true
            tobiLessBackgroundView.isHidden = true
        } else {
            tobiFace.isHidden = true
            tobiLessImageView.isHidden = false
            tobiLessImageView.image = UIImage.VFGLogo.dynamic
            tobiLessBackgroundView.isHidden = false
        }
    }

    // todo: refactor this method
    func setupButtons() {
        backButton.setImage(UIImage.VFGArrow.left, for: .normal)
        backButton.isHidden = true
        closeButton.isHidden = true

        let labelText = String(format: "login_more_information_text".localized(bundle: .login), "")
        moreInformationLabel.text = labelText
        let moreInformation = "login_more_information_label".localized(bundle: Bundle.login)
        if moreInformation == " " {
            moreInformationButton.removeFromSuperview()
        } else {
            moreInformationButton.setUnderlinedTitle(
                title: moreInformation,
                font: .vodafoneRegular(17),
                color: .VFGWhiteText,
                state: .normal)
        }

        separatorView.alpha = 0.23

        let changeLanguage = "login_change_language_label".localized(bundle: Bundle.login)
        changeLanguageButton.setUnderlinedTitle(
            title: changeLanguage + ":",
            font: .vodafoneRegular(17),
            color: .VFGWhiteText,
            state: .normal)

        selectedLanguageLabel.text = VFGLoginManager.currentLanguage.localized(bundle: Bundle.login)
    }

    @IBAction func backButtonAction(_ sender: Any) {
        fixedLineLoginObj?.backButtonAction()
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        if accountsListLoginImplementation != nil {
            accountsListLoginImplementation?.closeButtonAction()
        } else if upfrontLoginImplementation != nil {
            upfrontLoginImplementation?.closeButtonDidPress(viewController: self)
        }
    }

    // MARK: - presenting viewControllers
    func presentNextLoginViewController() {
        if let initialScreen = initialScreen {
            present(screenType: initialScreen)
            return
        }
        if fixedLineUpfrontLoginProtocol != nil {
            if let accounts = accountsListLoginImplementation?.retrieveSavedAccounts(), !accounts.isEmpty {
                presentAccountsListViewController()
            } else {
                presentChooseAccountType()
            }
        } else {
            if softLoginImplementation != nil {
                presentPhoneLoginViewController(shouldAnimate: false)
            } else if upfrontLoginImplementation != nil {
                presentEmailLoginViewController()
            }
        }
    }

    func embedViewControllers() {
        embedEmailViewController()
        embedPhoneLoginViewController()
        embedLoginVerificationViewController()
        embedFixedLineUpfrontLogin()
        embedChooseAccountType()
        embedLoginAccountsListViewController()
        addLoadingLogoView()
    }

    func addLoadingLogoView() {
        loadingLogoView = VFGLoadingLogoView.loadXib(bundle: .foundation)
        stackView.addArrangedSubview(loadingLogoView ?? UIView())
        loadingLogoView?.isHidden = true
    }

    func saveWhichViewIsPresented(
        isPhoneLoginPresented: Bool = false,
        isEmailLoginPresented: Bool = false,
        isLoginVerificationPresented: Bool = false,
        isChooseAccountPresented: Bool = false,
        isAccountsListPresented: Bool = false,
        isFixedLineUpfrontLoginPresented: Bool = false
    ) {
        self.isPhoneLoginPresented = isPhoneLoginPresented
        self.isEmailLoginPresented = isEmailLoginPresented
        self.isLoginVerificationPresented = isLoginVerificationPresented
        self.isChooseAccountPresented = isChooseAccountPresented
        self.isAccountsListPresented = isAccountsListPresented
        self.isFixedLineUpfrontLoginPresented = isFixedLineUpfrontLoginPresented
    }

    func presentedView() -> UIView? {
        if isPhoneLoginPresented {
            return loginPhoneObj?.view
        }
        if isEmailLoginPresented {
            return upfrontLoginObj?.view
        }
        if isLoginVerificationPresented {
            return loginVerification?.view
        }
        if isChooseAccountPresented {
            return chooseAccountView?.view
        }
        if isAccountsListPresented {
            return loginAccountsList?.view
        }
        if isFixedLineUpfrontLoginPresented {
            return fixedLineLoginObj?.view
        }
        return nil
    }
}

extension VFGLoginBaseViewController {
    func showLoadingLogo(text: String?) {
        UIView.animate(withDuration: animationsDuration) { [weak self] in
            self?.titleLabel.alpha = 0
            self?.actionButtonOne.alpha = 0
            self?.actionButtonTwo.alpha = 0
        }
        guard let animation = Animation.vodafoneLogo else {
            return
        }
        loadingLogoView?.configure(
            animation: animation,
            height: Constants.loginLoadingViewHeight,
            animationViewHeight: Constants.loginAnimationViewHeight,
            title: text,
            titleFont: UIFont.vodafoneRegular(17),
            titleTextColor: UIColor.VFGRedWhiteText)

        loadingLogoView?.startLoading()
        showAndHideViewsWithAnimation(
            viewToHide: presentedView(),
            viewToShow: loadingLogoView)
        softLoginImplementation?.tobiDelegate?.begin(
            animation: .whisle,
            tobiLessImage: UIImage.VFGLogo.dynamic ?? UIImage())
    }

    func shouldSkipHideViews() -> Bool {
        return isPhoneLoginPresented ||
            isEmailLoginPresented ||
            isFixedLineUpfrontLoginPresented ||
            isAccountsListPresented
    }

    func hideLoadingLogo(success: Bool) {
        UIView.animate(withDuration: animationsDuration) { [weak self] in
            self?.titleLabel.alpha = 1
            self?.actionButtonOne.alpha = 1
            self?.actionButtonTwo.alpha = 1
        }
        if success, (
            shouldSkipHideViews()
        ) {
            return
        }
        showAndHideViewsWithAnimation(
            viewToHide: loadingLogoView,
            viewToShow: presentedView())
    }

    // MARK: - IBActions
    @IBAction func actionButtonTwo(_ sender: Any) {
        if isEmailLoginPresented {
            upfrontLoginObj?.registerNow()
        } else if
            isAccountsListPresented ||
                isChooseAccountPresented {
            fixedLineLoginObj?.registerNow()
        } else {
            loginPhoneObj?.loginWithUserName()
        }
    }

    @IBAction func moreInformationButtonDidPress(_ sender: Any) {
        if seamlessLoginImplementation != nil,
            let viewController = seamlessLoginImplementation?.moreInformationViewController() {
            navigate(to: viewController)
        } else if upfrontLoginImplementation != nil,
            let viewController = upfrontLoginImplementation?.moreInformationViewController() {
            navigate(to: viewController)
        }
    }

    @IBAction func changeLanguageButtonDidPress(_ sender: Any) {
        if seamlessLoginImplementation != nil {
            seamlessLoginImplementation?.presentChangeLanguageViewController()
        } else if upfrontLoginImplementation != nil {
            upfrontLoginImplementation?.presentChangeLanguageViewController()
        }
    }
}

extension VFGLoginBaseViewController: VFGShowHideLoadingLogoProtocol {
    func show(with text: String?) {
        subtitleLabel.isHidden = true
        backButton.isHidden = true
        toggleFooterVisibility(isHidden: true)
        adjustLoginCardViewTopConstraint()
        showLoadingLogo(text: text)
    }

    func hide(with success: Bool) {
        backButton.isHidden = (fixedLineUpfrontLoginProtocol == nil)
        hideLoadingLogo(success: success)
    }
}

extension VFGLoginBaseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        statusBar?.backgroundColor = .VFGStatusBarBackground
    }
}
