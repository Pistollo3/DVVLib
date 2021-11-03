//
//  VFGSoftLoginProtocol.swift
//  VFGLogin
//
//  Created by Hussien Gamal Mohammed on 7/28/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import VFGMVA10Foundation

/// Defines the login status for user.
public enum VFGLoginResult {
    /**
    Success detects that user successfully logged in.
    - userData: Meta data about the user, for example, user type.
    */
    case success(userData: [String: Any]?)

    /**
    fail detects that user can't log in.
    - error: The error which cause login failure.
    */
    case fail(error: Error?)
}

/**
Allows user to login using a phone number.
- validate(phoneNumber:): Validation of phone number.
- registerUserViewController: Adding registration and forgotten password ViewControllers.
- phoneMaxLength: limit the max number of numbers the text field accepts.
- phoneNumber: user's phone number.
- phoneMinLength: Minimum number of characters to start validation.
- phoneAllowedCharacters: textfield will **only** allow these characters.
- tobiDelegate: delegate that handles Tobi animation.
*/
public protocol VFGSoftLoginProtocol: VFGLoginOTPDelegate {
    typealias SMSCompletion = (VFGLoginResult, _ errorMessageTitle: String?, _ errorMessageSubTitle: String?) -> Void
    func registerUserViewController() -> UIViewController
    func validate(phoneNumber: String) -> CredentialsValidationState
    @available(*, deprecated, message: "Conform to VFGLoginOTPDelegate instead")
    func validate(verificationCode: String) -> CredentialsValidationState
    @available(*, deprecated, message: "Conform to VFGLoginOTPDelegate instead")
    func sendSMSCode(phoneNumber: String, completion: SMSCompletion?)

    var phoneMaxLength: Int { get }
    var phoneNumber: String { get }
    var phoneMinLength: Int { get }
    var phoneAllowedCharacters: String { get }
    var tobiDelegate: VFGTobiHandlerDelegate? { get set }
}
extension VFGSoftLoginProtocol {
    public func sendSMSCode(phoneNumber: String, completion: SMSCompletion?) { }
    public func validate(verificationCode: String) -> CredentialsValidationState { .invalid }
}
protocol VFGSoftLoginInternalProtocol: AnyObject {
    func verificationCodeCompletion(result: VFGLoginResult)
}
