//
//  VFGFixedLineUpfrontLoginProtocol.swift
//  VFGMVA10Login
//
//  Created by Hamsa Hassan on 4/14/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public protocol VFGFixedLineUpfrontLoginProtocol: class {
    func login(
        emailOrPhone: String,
        password: String,
        isPersonal: Bool,
        rememberMe: Bool,
        completion: @escaping (VFGLoginResult, String?) -> Void
    )
    func isFrontendValid(emailOrPhone: String) -> Bool
    func isValidPassword(password: String) -> Bool
    func registerNowButtonDidPress(completion: (UIViewController) -> Void)
    func forgetPasswordButtonDidPress(completion: (UIViewController) -> Void)
    func viewDidLoad()
    func loginButtonDidPress(completion: @escaping (() -> Void))
    var usernameLengthRange: ClosedRange<Int> { get }
    var passwordLengthRange: ClosedRange<Int> { get }
    var usernameNotAllowedCharacters: String { get }
    var tobiDelegate: VFGTobiHandlerDelegate? { get set }
    var isRegistrationEnabled: Bool { get }
    var userNameKeyboardType: UIKeyboardType { get }
    var passwordKeyboardType: UIKeyboardType { get }
    var isSecondaryPlaceholderEnabled: Bool { get }
}

extension VFGFixedLineUpfrontLoginProtocol {
    // Methods
    public func registerNowButtonDidPress(completion: (UIViewController) -> Void) {
        completion(UIViewController())
    }
    public func forgetPasswordButtonDidPress(completion: (UIViewController) -> Void) {
        completion(UIViewController())
    }
    public func isValidPassword(password: String) -> Bool { true }
    public func viewDidLoad() {}
    public func loginButtonDidPress(completion: @escaping (() -> Void)) { completion() }

    public func login(
        emailOrPhone: String,
        password: String,
        isPersonal: Bool,
        rememberMe: Bool,
        completion: @escaping (VFGLoginResult, String?) -> Void
    ) {}

    // Variables
    public var usernameLengthRange: ClosedRange<Int> { 6...Int.max }
    public var passwordLengthRange: ClosedRange<Int> { 1...Int.max }
    public var usernameNotAllowedCharacters: String { " \"!#$%&'()*,/:;<=>?][^`{|}~-\\" }
    public var isRegistrationEnabled: Bool { true }
    public var userNameKeyboardType: UIKeyboardType { .emailAddress }
    public var passwordKeyboardType: UIKeyboardType { .emailAddress }
    public var isSecondaryPlaceholderEnabled: Bool { false }
}

protocol VFGFixedLineUpfrontLoginInternalProtocol: class {
    func fixedLineUpFrontCompletion(result: VFGLoginResult)
}
