//
//  VFGLoginBaseViewController+Keyboard.swift
//  VFGLogin
//
//  Created by Hussein Kishk on 21/12/2020.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

// MARK: Keyboard Show and Hide
extension VFGLoginBaseViewController {
    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize =
            (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight.constant = keyboardSize.height
            viewInScroll.setNeedsLayout()
            keyboardView.setNeedsLayout()
            containerScrollView.setNeedsLayout()
            UIView.animate(withDuration: 0.5) {
                self.keyboardView.layoutIfNeeded()
                self.containerScrollView.layoutIfNeeded()
                self.containerScrollView.layoutSubviews()
                self.viewInScroll.layoutIfNeeded()
                self.viewInScroll.layoutSubviews()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardHeight.constant = 0
        containerScrollView.setNeedsLayout()
        keyboardView.setNeedsLayout()
        viewInScroll.setNeedsLayout()
        UIView.animate(withDuration: 0.5) {
            self.keyboardView.layoutIfNeeded()
            self.containerScrollView.layoutIfNeeded()
            self.containerScrollView.layoutSubviews()
            self.viewInScroll.layoutIfNeeded()
            self.viewInScroll.layoutSubviews()
        }
    }
}
