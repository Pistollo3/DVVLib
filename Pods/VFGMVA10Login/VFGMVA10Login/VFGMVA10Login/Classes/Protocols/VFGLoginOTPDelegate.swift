//
//  VFGLoginOTPDelegate.swift
//  VFGMVA10Login
//
//  Created by Hussien Gamal Mohammed Fahmy on 17/05/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
/**
Allows user to implement the logic of verification screen for any login screen.
- sendVerificationCode: Sends a verification code to the user by SMS or email.
- validate: Validating the verification code is entered correctly.
- verify: verify if verification code is correct.
**/
public protocol VFGLoginOTPDelegate: class {
    var resendCodeCountDownSeconds: Int { get }
    typealias VerificationCompletion = (VFGLoginResult, _ errorMessageTitle: String?) -> Void
    func validate(verificationCode: String) -> CredentialsValidationState
    func sendVerificationCode(emailOrPhone: String, completion: VerificationCompletion?)
    func verify(verificationCode: String, completion: @escaping (VFGLoginResult, String?) -> Void)
}
public extension VFGLoginOTPDelegate {
    var resendCodeCountDownSeconds: Int {
        30
    }

    func verify(verificationCode: String, completion: @escaping (VFGLoginResult, String?) -> Void) {}
}
