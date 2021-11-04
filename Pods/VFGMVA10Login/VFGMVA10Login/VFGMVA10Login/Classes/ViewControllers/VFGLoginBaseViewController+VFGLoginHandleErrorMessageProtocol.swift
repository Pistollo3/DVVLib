//
//  VFGLoginBaseViewController+VFGLoginHandleErrorMessageProtocol.swift
//  VFGLogin
//
//  Created by Hussein Kishk on 21/12/2020.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

// MARK: Error Message
extension VFGLoginBaseViewController: VFGLoginHandleErrorMessageProtocol {
    func setupAccessibilityIdentifier(titleId: String) {
        errorTitleLabel.accessibilityIdentifier = titleId
    }

    func showErrorMessageView(title: String) {
        errorTitleLabel.text = title
        if errorMessageContainer.isHidden == true {
            self.errorMessageContainer.alpha = 0
            UIView.animate(withDuration: animationsDuration) {
                self.errorMessageContainer.isHidden = false
                self.errorMessageSeparator.isHidden = false
                self.errorMessageContainer.alpha = 1
            }
        }
    }

    func hideErrorMessageView() {
        if errorMessageContainer.isHidden == false {
            self.errorMessageContainer.alpha = 1
            UIView.animate(withDuration: animationsDuration) {
                self.errorMessageContainer.isHidden = true
                self.errorMessageSeparator.isHidden = true
                self.errorMessageContainer.alpha = 0
            }
        }
    }
}
