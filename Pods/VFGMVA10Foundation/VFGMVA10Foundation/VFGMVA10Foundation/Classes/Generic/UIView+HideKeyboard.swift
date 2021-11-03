//
//  UIView+HideKeyboard.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 10/6/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

extension UIView {
    public func addKeyboardDismissHandler() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(
                target: self,
                action: #selector(dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }
}
