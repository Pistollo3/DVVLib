//
//  VFGLoginHandleErrorMessageProtocol.swift
//  VFGLogin
//
//  Created by Esraa Eldaltony on 10/30/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

/**
Error message.
- showErrorMassageView: Show error message view with title.
- hideErrorMessageView: Hide error message view.
- setupAccessibilityIdentifier: Setup error view accessibility identifier with titleId.
*/
protocol VFGLoginHandleErrorMessageProtocol: class {
    func showErrorMessageView(title: String)
    func hideErrorMessageView()
    func setupAccessibilityIdentifier(titleId: String)
}
