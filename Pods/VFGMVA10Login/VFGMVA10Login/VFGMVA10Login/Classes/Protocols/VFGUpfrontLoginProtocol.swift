//
//  VFGUpfrontLoginProtocol.swift
//  VFGLogin
//
//  Created by Hussien Gamal Mohammed on 7/28/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation

/**
Allows user to login using a username and password.
- login: Login using an API and checking if it succeeds or fails.
- isFrontendValid: Validate the user input.
- registerUserViewController: Adding registration ViewController.
- forgetPasswordViewController: Adding forgotten password ViewController.
- resetAccountViewController: Adding reset password ViewController.
- mailLengthRange: Range number of characters allowed in mail field.
- passwordLengthRange: Range number of characters allowed in password field.
- mailNotAllowedCharacters: textfield won't accept these characters.
- tobiDelegate: delegate that handles Tobi animation.
*/
public protocol VFGUpfrontLoginProtocol: AnyObject {
    func login(
        emailOrPhone: String,
        password: String,
        rememberMe: Bool,
        completion: @escaping (VFGLoginResult, String?) -> Void
    )
    func loginButtonDidPress(completion: @escaping (() -> Void))
    func biometricLoginButtonDidPress(completion: @escaping (() -> Void))
    func authenticateBiometricLogin(completion: @escaping (() -> Void))
    func isFrontendValid(emailOrPhone: String) -> Bool
    func isValidPassword(password: String) -> Bool
    func registerNowButtonDidPress(completion: (UIViewController) -> Void)
    func forgetPasswordButtonDidPress(completion: (UIViewController) -> Void)
    func resetAccountButtonDidPress(completion: (UIViewController) -> Void)
    func moreInformationViewController() -> UIViewController?
    func presentChangeLanguageViewController()
    func closeButtonDidPress(viewController: UIViewController)

    var mailLengthRange: ClosedRange<Int> { get }
    var passwordLengthRange: ClosedRange<Int> { get }
    var mailNotAllowedCharacters: String { get }
    var tobiDelegate: VFGTobiHandlerDelegate? { get set }
    var isRegistrationEnabled: Bool { get }
    var emailOrPhoneKeyboardType: UIKeyboardType { get }
    var passwordKeyboardType: UIKeyboardType { get }
    var isSecondaryPlaceholderEnabled: Bool { get }
    var loginType: UpfrontLoginType { get }
    var isRememberMeEnabled: Bool { get }
}

extension VFGUpfrontLoginProtocol {
    // Methods
    public func registerNowButtonDidPress(completion: (UIViewController) -> Void) {
        completion(UIViewController())
    }

    public func forgetPasswordButtonDidPress(completion: (UIViewController) -> Void) {
        completion(UIViewController())
    }

    public func resetAccountButtonDidPress(completion: (UIViewController) -> Void) {
        completion(UIViewController())
    }

    public func moreInformationViewController() -> UIViewController? { nil }

    public func presentChangeLanguageViewController() {}

    public func isValidPassword(password: String) -> Bool { true }

    public func closeButtonDidPress(viewController: UIViewController) {}

    public func login(
        emailOrPhone: String,
        password: String,
        rememberMe: Bool,
        completion: @escaping (VFGLoginResult, String?) -> Void
    ) {}

    // Variables
    public var mailLengthRange: ClosedRange<Int> { 6...Int.max }
    public var passwordLengthRange: ClosedRange<Int> { 1...Int.max }
    public var mailNotAllowedCharacters: String { " \"!#$%&'()*,/:;<=>?][^`{|}~-\\" }
    public var isRegistrationEnabled: Bool { true }
    public var emailOrPhoneKeyboardType: UIKeyboardType { .emailAddress }
    public var passwordKeyboardType: UIKeyboardType { .emailAddress }
    public var isSecondaryPlaceholderEnabled: Bool { false }
    public var loginType: UpfrontLoginType { .default }
    public var isRememberMeEnabled: Bool { false }
    public func loginButtonDidPress(completion: @escaping (() -> Void)) { completion() }
    public func biometricLoginButtonDidPress(completion: @escaping (() -> Void)) { completion() }
    public func authenticateBiometricLogin(completion: @escaping (() -> Void)) { completion() }
}

protocol VFGUpfrontLoginInternalProtocol: class {
    func upFrontCompletion(result: VFGLoginResult)
}
