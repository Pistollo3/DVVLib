//
//  VFQuickActionsViewController.swift
//  VFGMVA10Foundation
//
//  Created by Sandra Morcos on 7/25/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public class VFQuickActionsViewController: UIViewController {
    @IBOutlet weak var quickActionsView: UIView!
    @IBOutlet weak var pillView: UIView!
    @IBOutlet weak var titleLabel: VFGLabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var originalProportionalHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeButton: VFGButton!
    @IBOutlet weak var backButton: VFGButton!
    @IBOutlet weak var titleLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerButton: VFGButton!
    @IBOutlet weak var keyboardHeightConstraint: NSLayoutConstraint!
    var proportionalHeight: NSLayoutConstraint?

    var model: VFQuickActionsModel?
    let maximumHeightRatio: CGFloat = 0.95
    var isPresented = false

    var contentView: UIView?

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        model?.quickActionsProtocol(delegate: self)
        observeKeyboard()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !isPresented else { return }
        UIView.animate(withDuration: 0.1) {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            let transform = CGAffineTransform(translationX: 0, y: 0)
            self.pillView.transform = transform
            self.quickActionsView.transform = transform
            self.isPresented = true
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard !isPresented else { return }

        view.backgroundColor = .clear

        let transform = CGAffineTransform(translationX: 0, y: quickActionsView.frame.height)
        pillView.transform = transform
        quickActionsView.transform = transform
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                if model?.quickActionsStyle == .red {
                    quickActionsView.layer.sublayers?.first?.removeFromSuperlayer()
                    quickActionsView.setGradientBackgroundColor(colors: UIColor.VFGRedGradientDynamic)
                }
            }
        }
    }

    private func setupUI() {
        titleLabel.text = model?.quickActionsTitle
        titleLabel.font = model?.titleFont
        titleLabel.numberOfLines = 0
        headerButton.titleLabel?.font = model?.titleFont
        if model?.quickActionsStyle == .red {
            quickActionsView.setGradientBackgroundColor(colors: UIColor.VFGRedGradientDynamic)
            titleLabel.textColor = .white
            closeButton.tintColor = .white
        } else {
            quickActionsView.backgroundColor = .VFGWhiteBackground
            titleLabel.textColor = .VFGPrimaryText
            closeButton.tintColor = .VFGGreyTint
        }
        quickActionsView.roundUpperCorners(cornerRadius: 6)
        setupContentView()
        if model?.isUserInteractionEnabled ?? false {
            pillView.isHidden = false
            let panGestureRecognizer = UIPanGestureRecognizer(
                target: self,
                action: #selector(viewControllerDragged(_:)))
            view.addGestureRecognizer(panGestureRecognizer)
        }
        setupAccessibilityIDs()
    }

    @objc func viewControllerDragged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        updateDragging(translation.y, state: gesture.state)
    }

    func updateDragging(_ yPosition: CGFloat, state: UIGestureRecognizer.State) {
        if yPosition > 0 {
            let transform = CGAffineTransform(translationX: 0, y: yPosition)
            pillView.transform = transform
            quickActionsView.transform = transform
        }
        guard state == .ended else { return }
        if yPosition >= quickActionsView.frame.height / 2 {
            model?.closeQuickAction()
        } else {
            UIView.animate(withDuration: 0.1) {
                let transform = CGAffineTransform(translationX: 0, y: 0)
                self.pillView.transform = transform
                self.quickActionsView.transform = transform
            }
        }
    }

    func updateHeightFor(_ contentView: UIView) {
        let actualHeight = (contentView.frame.height
            + self.quickActionsView.frame.height
            - self.scrollView.frame.height)
        var multiplier = actualHeight / self.view.frame.height

        if multiplier > self.maximumHeightRatio {
            multiplier = self.maximumHeightRatio
        }
        if self.originalProportionalHeightConstraint != nil {
            self.originalProportionalHeightConstraint.isActive = false
        }
        self.proportionalHeight = self.quickActionsView.heightAnchor.constraint(
            equalTo: self.view.heightAnchor,
            multiplier: multiplier,
            constant: 0
        )
        self.proportionalHeight?.isActive = true
    }
    private func setupContentView() {
        guard let model = model else {
            return
        }

        backButton.isHidden = model.isBackButtonHidden
        backButton.imageName = "icArrowLeft"
        titleLabelLeadingConstraint.constant = model.isBackButtonHidden ? 16 : 58

        headerButton.isHidden = model.isHeaderButtonHidden
        headerButton.setTitle(model.headerButtonTitle, for: .normal)
        if let closeImage = model.closeButtonImage {
            closeButton.setImage(closeImage, for: .normal)
        }
        closeButton.isHidden = model.isCloseButtonHidden
        closeButton.alpha = model.isCloseButtonHidden ? 0 : 1

        let contentView = model.quickActionsContentView
        scrollView.embed(view: contentView)
        contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        contentView.layoutIfNeeded()
        updateHeightFor(contentView)
        self.contentView = contentView
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.view.layoutSubviews()
            if self.model?.quickActionsStyle == .red {
                self.quickActionsView.backgroundColor = .VFGRedGradientEnd
            } else {
                self.quickActionsView.backgroundColor = .VFGWhiteBackground
            }
            self.quickActionsView.layer.sublayers?.first?.frame = self.quickActionsView.bounds
            self.quickActionsView.layer.layoutSublayers()
        }
    }

    private func reloadView() {
        contentView?.removeFromSuperview()
        proportionalHeight?.isActive = false
        titleLabel.text = model?.quickActionsTitle
        titleLabel.font = model?.titleFont
        headerButton.titleLabel?.font = model?.titleFont
        setupContentView()
    }

    private func setupAccessibilityIDs() {
        let model = self.model?.accessibilityModel ?? VFQuickActionsAccessibilityModel()
        view.accessibilityIdentifier = model.mainView
        titleLabel.accessibilityIdentifier = model.title
        closeButton.accessibilityIdentifier = model.closeButton
        backButton.accessibilityIdentifier = model.backButton
        headerButton.accessibilityIdentifier = model.headerButton
    }

    @IBAction func dismissViewController(_ sender: VFGButton) {
        guard
            sender == closeButton ||
            model?.isUserInteractionEnabled ?? false else { return }
        model?.closeQuickAction()
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        model?.backQuickAction()
    }

    func animatedDismiss(completion: (() -> Void)?) {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.view.backgroundColor = .clear
                let transform = CGAffineTransform(translationX: 0, y: self.quickActionsView.frame.height)
                self.pillView.transform = transform
                self.quickActionsView.transform = transform
            }, completion: { [weak self] _ in
                guard let self = self else { return }
                self.dismiss(animated: false) {
                    completion?()
                }
            })
    }

    @IBAction func headerButtonTapped(_ sender: Any) {
        model?.headerButtonAction()
    }

    static func viewController(with model: VFQuickActionsModel) -> VFQuickActionsViewController {
        let storyboard = UIStoryboard(name: "quickActions", bundle: Bundle.foundation)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "VFQuickActionsViewController")
            as? VFQuickActionsViewController else {
                return VFQuickActionsViewController()
        }
        viewController.model = model
        return viewController
    }

    /// To present QuickActionsViewController with a given model
    public static func presentQuickActionsViewController(with model: VFQuickActionsModel, presentationStyle: UIModalPresentationStyle? = nil) {
        guard let navigationController = UIApplication.topViewController() else {
            return
        }

        let viewController = VFQuickActionsViewController.viewController(with: model)
        if let modalPresentationStyle = presentationStyle {
            viewController.modalPresentationStyle = modalPresentationStyle
        }
        navigationController.present(
            viewController,
            animated: false,
            completion: nil)
    }

    private func observeKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidAppear),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidDisappear),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    @objc func keyboardDidAppear (notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        keyboardHeightConstraint.constant = (model?.shouldRaiseForKeyboard ?? false) ? (keyboardFrame?.height ?? 0) : 0
    }

    @objc func keyboardDidDisappear() {
        keyboardHeightConstraint.constant = 0
    }
}

extension VFQuickActionsViewController: VFQuickActionsProtocol {
    public func reloadQuickAction(model: VFQuickActionsModel?) {
        guard let newModel = model else { return }
        self.model = newModel
        self.model?.quickActionsProtocol(delegate: self)
        reloadView()
    }

    public func closeQuickAction(completion: (() -> Void)?) {
        animatedDismiss(completion: completion)
    }

    public func shouldScroll(height: CGFloat) {
        scrollView.contentOffset = CGPoint(x: 0, y: height)
    }
}
