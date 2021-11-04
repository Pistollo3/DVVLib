//
//  UIViewController+HideKeyboard.swift
//  VFGMVA10Foundation
//
//  Created by Esraa Eldaltony on 7/10/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

extension UIViewController {
    public func addKeyboardDismissHandler() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(
                target: self,
                action: #selector(UIViewController.dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
}
