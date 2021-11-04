//
//  UIViewController+embedViewControllerInStack.swift
//  VFGLogin
//
//  Created by Esraa Eldaltony on 10/30/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

extension UIViewController {
    func embed(_ viewController: UIViewController, inStackView stackView: UIStackView) {
        viewController.willMove(toParent: self)
        stackView.addArrangedSubview(viewController.view)
        addChild(viewController)
        viewController.didMove(toParent: self)
    }

    func showAndHideViewsWithAnimation(
        viewToHide: UIView?,
        viewToShow: UIView?
    ) {
        UIView.animate(withDuration: 0.1) {
            viewToHide?.alpha = 0
        }

        UIView.animate(withDuration: 0.3) {
            viewToHide?.isHidden = true
            viewToShow?.isHidden = false
            viewToShow?.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.1) {
            viewToShow?.alpha = 1
        }
    }
}
