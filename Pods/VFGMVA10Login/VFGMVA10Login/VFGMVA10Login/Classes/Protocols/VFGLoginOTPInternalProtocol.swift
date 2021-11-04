//
//  VFGLoginOTPInternalProtocol.swift
//  VFGLogin
//
//  Created by Hussien Gamal Mohammed on 7/30/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//
import Foundation

/**
VFGLoginOTPInternalProtocol.
- verificationCodeCompletion: Completion of verifying verification code either with success or failure.
*/
protocol VFGLoginOTPInternalProtocol: class {
    func changeButtonDidPress()
    func resendButtonDidPress()
    func verificationCodeCompletion(result: VFGLoginResult)
    var changeButtonTitle: String { get }
}
extension VFGLoginOTPInternalProtocol {
    func changeButtonDidPress() {}
    func resendButtonDidPress() {}
}
