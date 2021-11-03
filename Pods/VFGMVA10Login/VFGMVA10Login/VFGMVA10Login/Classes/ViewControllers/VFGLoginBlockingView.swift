//
//  VFGLoginBlockingView.swift
//  VFGLogin
//
//  Created by Hamsa Hassan on 12/16/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

class VFGLoginBlockingView: VFQuickActionsModel {
    var blockingViewTitle = "upfront_login_blocked_warning_subtitle".localized(bundle: .login)
    var blockingViewText = "upfront_login_blocked_warning_text".localized(bundle: .login)
    var quickActionsTitle: String = "upfront_login_blocked_warning_title".localized(bundle: .login)
    var quickActionsStyle: VFQuickActionsStyle = .white
    var quickActionsContentView: UIView {
        guard let blockingView: VFGTwoActionsView = UIView.loadXib(bundle: Bundle.foundation) else {
            return UIView()
        }
        blockingView.delegate = twoActionsDelegate
        configureBlockingView(blockingView: blockingView)
        return blockingView
    }
    weak var twoActionsDelegate: VFGTwoActionsViewProtocol?
    weak var delegate: VFQuickActionsProtocol?
    var userEmail: String?

    init(userEmail: String?) {
        self.userEmail = userEmail
    }

    func quickActionsProtocol(delegate: VFQuickActionsProtocol) {
        self.delegate = delegate
    }

    func closeQuickAction() {
        delegate?.closeQuickAction(completion: nil)
    }

    func configureBlockingView(blockingView: VFGTwoActionsView) {
        let primaryButtonTitle = "upfront_login_reset_account_login_button".localized(bundle: Bundle.login)
        let secondaryButtonTitle =
            "upfront_login_different_account_login_button".localized(bundle: Bundle.login)
        let descriptionAttributedString = mailAttributedText(userEmail: userEmail ?? "")
        let titlesModel = VFGTitlesModel(
            title: blockingViewTitle,
            description: nil,
            descriptionAttributedString: descriptionAttributedString,
            moreDetails: nil,
            primaryButtonTitle: primaryButtonTitle,
            secondaryButtonTitle: secondaryButtonTitle)
        let titlesFont = VFGTitlesFontModel(titleFont: .vodafoneLite(25))
        let accessibilityIDsModel = VFGTwoActionsAccessibilityModel(
            title: "loginBlockedTitle",
            primaryButton: "loginResetButton",
            secondaryButton: "loginDiffAccount")
        blockingView.configure(
            viewStyle: .white,
            titlesModel: titlesModel,
            titlesFontModel: titlesFont,
            accessibilityIDsModel: accessibilityIDsModel)
    }

    func mailAttributedText(userEmail: String) -> NSMutableAttributedString {
        let formattedString = String(format: blockingViewText, userEmail)
        // attributed string
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.vodafoneRegular(17),
            .foregroundColor: UIColor.VFGPrimaryText
        ]
        let mailAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.vodafoneBold(16),
            .foregroundColor: UIColor.VFGPrimaryText
        ]
        let textAttributeString = NSMutableAttributedString(
            string: formattedString,
            attributes: textAttributes)
        guard let formatterStrRange = formattedString.range(of: userEmail) else {
            return textAttributeString
        }
        let nsRange = NSRange(formatterStrRange, in: formattedString)
        textAttributeString.addAttributes(mailAttributes, range: nsRange)
        return textAttributeString
    }
}
