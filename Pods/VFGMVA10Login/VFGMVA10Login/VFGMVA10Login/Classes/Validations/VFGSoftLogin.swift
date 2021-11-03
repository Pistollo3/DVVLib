//
//  VFGSoftLogin.swift
//  VFGLogin
//
//  Created by Esraa Eldaltony on 7/29/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

/// Default implementation for VFGSoftLoginProtocol
public class VFGSoftLogin: VFGSoftLoginProtocol {
    private var loginNetworkProvider: VFGLoginProvider?
    weak public var tobiDelegate: VFGTobiHandlerDelegate?
    public static var isAPIRequestEnabled: Bool?
    var userData: [String: Any] = [:]

    public init(isAPIRequestEnabled: Bool? = false) {
        VFGSoftLogin.isAPIRequestEnabled = isAPIRequestEnabled
        loginNetworkProvider = VFGLoginProvider()
    }
    public var phoneNumber: String = ""
    var payGPhoneNumber = "07121212121"
    var sohoPhoneNumber = "07123123123"

    public var phoneMaxLength: Int {
        return 14
    }
    public var phoneMinLength: Int {
        return 6
    }
    public var phoneAllowedCharacters: String {
        return "+0123456789"
    }

    public func registerUserViewController() -> UIViewController {
        let viewModel = VFGWebViewModel(urlString: Constants.registerUserUrl)
        return VFGWebViewController.instance(with: viewModel, delegate: self)
    }

    public func validate(phoneNumber: String) -> CredentialsValidationState {
        return VFGSoftLogin.validate(phoneNumber: phoneNumber)
    }

    class func validate(phoneNumber: String) -> CredentialsValidationState {
        var ukRegex = "(\\+44|0044|0)7[0-9]{9}"
        if VFGSoftLogin.isAPIRequestEnabled ?? false {
            // This is a temp logic for scenario on API request disabled or enabled
            // 307919111111 valid number for api
            ukRegex = "[0-9]{12}"
        }
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", ukRegex)
        if phonePredicate.evaluate(with: phoneNumber) {
            return .valid
        }
        return .invalidFormat
    }

    func setUserType(phoneNumber: String) {
        switch phoneNumber {
        case payGPhoneNumber:
            userData["userType"] = VFGUserType.payG
        case sohoPhoneNumber:
            userData["userType"] = VFGUserType.soho
        default:
            userData["userType"] = VFGUserType.payM
        }
    }

    public func sendVerificationCode(
        emailOrPhone: String,
        completion: VerificationCompletion?
    ) {
        phoneNumber = emailOrPhone
        let bodyParameters = loginNetworkProvider?.createParametersForGetPinCode(phoneNumber: phoneNumber)
        let authRequest = loginNetworkProvider?.createPinCodeRequest(
            bodyParameters: bodyParameters ?? VFGParameters(),
            path: "/OTPLogin/v1/authorize")
        loginNetworkProvider = VFGLoginProvider(
            loginRequest: authRequest,
            isAPIRequestEnabled: VFGSoftLogin.isAPIRequestEnabled)
        loginNetworkProvider?.getPinCodeRequest(
            model: LoginResponse.self) { [weak self] response, _ in
                guard let self = self else { return }
                guard response != nil else {
                    // This is a temp logic for scenario on API request disabled
                    if (self.phoneNumber == "07123456789" && !(VFGSoftLogin.isAPIRequestEnabled ?? false))
                        || (VFGSoftLogin.isAPIRequestEnabled ?? false) {
                        self.tobiDelegate?.begin(
                            animation: .sad,
                            tobiLessImage: self.vodafoneLogo)
                        completion?(
                            .fail(error: nil),
                            "soft_login_error_title".localized(bundle: Bundle.login))
                    } else {
                        self.setUserType(phoneNumber: self.phoneNumber)
                        completion?(.success(userData: self.userData), nil)
                    }
                    return
                }
            self.setUserType(phoneNumber: self.phoneNumber)
            completion?(.success(userData: self.userData), nil)
        }
    }

    public func verify(
        verificationCode: String,
        completion: @escaping (VFGLoginResult, String?) -> Void
    ) {
        let code = loginNetworkProvider?.convertPinTobase64(pin: verificationCode, phone: phoneNumber) ?? ""
        loginNetworkProvider = VFGLoginProvider(isAPIRequestEnabled: VFGSoftLogin.isAPIRequestEnabled)
        loginNetworkProvider?.requestSoftLoginAuthentication(
            code: code,
            path: "/OTPLogin/v1/token") { [weak self] response, error in
            guard let self = self
            else { return }
            guard response != nil else {
                // This is a temp logic for success scenario on API request disabled
                if verificationCode == "1234", !(VFGSoftLogin.isAPIRequestEnabled ?? false) {
                    completion(.success(userData: self.userData), nil)
                } else {
                    self.tobiDelegate?.begin(
                        animation: .sad,
                        tobiLessImage: self.vodafoneLogo)
                    completion(.fail(error: CredentialsValidationState.invalidFormat), nil)
                }
                return
            }
            completion(.success(userData: self.userData), nil)
        }
    }

    public func validate(
        verificationCode: String
    ) -> CredentialsValidationState {
        if !verificationCode.isEmpty {
            tobiDelegate?.begin(
                animation: .whisle,
                tobiLessImage: vodafoneLogo)
        }
        let pattern = "[0-9]{4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        if predicate.evaluate(with: verificationCode) {
            return .valid
        }
        if !verificationCode.isEmpty {
            tobiDelegate?.begin(
                animation: .sad,
                tobiLessImage: vodafoneLogo)
        }
        return .invalidFormat
    }

    func verificationCodeSuccess() {
    }

    func verificationCodeFail(state: CredentialsValidationState) {
    }
}

extension VFGSoftLogin: VFGWebViewDelegate {
    public func close(sender viewController: VFGWebViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
}

extension VFGSoftLogin {
    var vodafoneLogo: UIImage {
        UIImage.VFGLogo.dynamic ?? UIImage()
    }
}
