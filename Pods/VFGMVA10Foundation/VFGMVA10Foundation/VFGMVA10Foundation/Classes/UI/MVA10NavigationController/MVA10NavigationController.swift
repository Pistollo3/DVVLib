//
//  MVA10NavigationController.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 12/10/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public class MVA10NavigationController: UINavigationController {
    // MARK: - private properties
    private(set) lazy var navigationView: MVA10NavigationView = {
        MVA10NavigationView.loadXib(bundle: Bundle.foundation) ?? MVA10NavigationView()
    }()
    private(set) var titles: [UIViewController: String] = [:]
    private(set) var accessibilityIDs: [UIViewController: String] = [:]
    private let statusBarHeight = UIApplication.shared.statusBarFrame.height
    private var extraSafeArea: CGFloat {
        16.0 + navigationBar.frame.height
    }
    private var topVC: UIViewController {
        topViewController ?? UIViewController()
    }

    // MARK: - public properties
    public weak var navigationDelegate: VFGNavigationControllerProtocol?
    public var isTranslucent = false {
        didSet {
            isTransparentBackground = isTranslucent
            additionalSafeAreaInsets.top = isTranslucent ? 0 : extraSafeArea
        }
    }
    public var isTransparentBackground = false {
        didSet {
            navigationView.isTransparentBackground = isTransparentBackground
        }
    }

    public var hasDivider = false {
        didSet {
            navigationView.hasDivider = hasDivider
        }
    }

    public var isNavigationViewHidden = false {
        willSet {
            navigationView.isHidden = newValue
            if newValue == true {
                resetSafeArea()
            } else if isNavigationViewHidden == true && newValue == false {
                increaseSafeArea()
            }
        }
    }

    public var isCloseButtonHidden = false {
        didSet {
            navigationView.closeButton.isHidden = isCloseButtonHidden
        }
    }

    public var isBackButtonHidden = false {
        didSet {
            navigationView.backButton.isHidden = isBackButtonHidden
        }
    }

    // MARK: - lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationViewFrame()
        setNavigationViewTitle()
        addNavigationViewButtons()
        increaseSafeArea()

        view.addSubview(navigationView)
        navigationBar.isHidden = true
    }

    // MARK: - private methods
    private func setNavigationViewFrame() {
        var height = extraSafeArea
        if UIScreen.screenHasNotch {
            height += (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? statusBarHeight)
        } else {
            height += statusBarHeight
        }
        navigationView.frame = CGRect(
            x: navigationBar.frame.origin.x,
            y: navigationBar.frame.origin.y,
            width: navigationBar.frame.width,
            height: height)
    }

    private func addNavigationViewButtons() {
        navigationView.backButton.addTarget(
            self,
            action: #selector(backTapped),
            for: .touchUpInside)
        navigationView.closeButton.addTarget(
            self,
            action: #selector(closeTapped),
            for: .touchUpInside)
        navigationView.backButton.isHidden = viewControllers.count < 2
    }

    private func setNavigationViewTitle() {
        navigationView.setTitle(
            title: titles[topVC] ?? "",
            accessibilityIdentifier: accessibilityIDs[topVC] ?? ""
        )
    }

    private func increaseSafeArea() {
        additionalSafeAreaInsets.top += extraSafeArea
    }

    private func resetSafeArea() {
        additionalSafeAreaInsets.top -= extraSafeArea
    }

    private func adjustBackButtonVisibility() {
        navigationView.backButton.isHidden = viewControllers.count < 2
    }

    private func executePopAction(_ poppedViewControllers: [UIViewController]) -> [UIViewController] {
        DispatchQueue.main.async { [weak self] in
            self?.adjustBackButtonVisibility()
        }
        let oldTitle = titles[topVC]
        let oldID = accessibilityIDs[topVC]
        poppedViewControllers.forEach {
            titles.removeValue(forKey: $0)
            accessibilityIDs.removeValue(forKey: $0)
            navigationView.setTitle(
                title: oldTitle ?? "",
                accessibilityIdentifier: oldID ?? "")
        }

        return poppedViewControllers
    }

    // MARK: - public methods
    public func setTitle(
        title: String,
        accessibilityID: String = "",
        for viewController: UIViewController
    ) {
        titles[viewController] = title
        accessibilityIDs[viewController] = accessibilityID
        navigationView.setTitle(
            title: title,
            accessibilityIdentifier: accessibilityID)
    }

    public func setupCustomColors(
        backgroundColor: UIColor = .VFGWhiteBackground,
        titleColor: UIColor = .VFGGreyTint,
        closeButtonColor: UIColor = .VFGGreyTint,
        backButtonColor: UIColor = .VFGGreyTint
    ) {
        navigationView.setupColors(
            backgroundColor: backgroundColor,
            titleColor: titleColor,
            closeButtonColor: closeButtonColor,
            backButtonColor: backButtonColor)
    }

    public func setAccessibilityIDs(closeButtonID: String = "", backButtonID: String = "") {
        navigationView.setAccessibilityIDs(closeButtonID: closeButtonID, backButtonID: backButtonID)
    }

    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        modalPresentationStyle = .fullScreen
        super.pushViewController(viewController, animated: animated)
        adjustBackButtonVisibility()
        let title = titles[topVC]
        let accessibilityID = accessibilityIDs[topVC]
        navigationView.setTitle(
            title: title ?? "",
            accessibilityIdentifier: accessibilityID ?? "")
    }

    public override func popViewController(animated: Bool) -> UIViewController? {
        guard let poppedViewController = super.popViewController(animated: animated) else {
            return nil
        }
        return executePopAction([poppedViewController]).first
    }

    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        guard let poppedViewControllers = super.popToRootViewController(animated: animated) else {
            return nil
        }
        return executePopAction(poppedViewControllers)
    }

    public override func popToViewController(
        _ viewController: UIViewController,
        animated: Bool
    ) -> [UIViewController]? {
        guard let poppedViewControllers = super.popToViewController(
            viewController,
            animated: animated) else {
            return nil
        }

        return executePopAction(poppedViewControllers)
    }

    @objc public func closeTapped() {
        if let delegate = navigationDelegate {
            delegate.closeButtonDidPress()
            return
        }
        guard let navigationController = navigationController else {
            dismiss(animated: true) {  [weak self] in
                guard let self = self else {
                    return
                }

                self.viewControllers.forEach { $0.dismiss(animated: false, completion: nil) }
                self.titles = [:]
                self.accessibilityIDs = [:]
            }
            return
        }
        navigationController.dismiss(animated: true) { [weak self] in
            guard let self = self else {
                return
            }
            self.viewControllers.forEach { $0.dismiss(animated: false, completion: nil) }
            self.titles = [:]
            self.accessibilityIDs = [:]
        }
    }

    @objc public func backTapped() {
        if let delegate = navigationDelegate {
            delegate.backButtonDidPress()
            return
        }
        _ = popViewController(animated: true)
    }
}
