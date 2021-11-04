//
//  AccessibilityIdentifier.swift
//  VFGLogin
//
//  Created by Ahmed Sultan on 12/12/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

extension VFGLoginBaseViewController {
    public enum BaseAccessibilityIds: String {
        case actionButtonOneForEmailLogin = "loginNotRegisteredTxt"
        case actionButtonTwoForEmailLogin = "loginRegisterNowLink"
        case actionButtonOneForPhoneLogin = "loginRegisteredTxt"
        case actionButtonTwoForPhoneLogin = "loginUsernameLink"
    }
}

extension VFGLoginEmail {
    public enum EmailAccessibilityIds: String {
        case passwordTextFieldId = "loginPassTxt"
        case emailTextFieldId = "loginEmailTxt"
        case rememberMeToggleId = "loginRememberToggle"
        case forgetPasswordButtonId = "loginForgetYourPassLink"
        case loginButtonId = "loginLoginButton"
        static var rightButtonIdentifierEmail: String {
            "text_input_end_icon"
        }
        static var rightButtonIdentifierPassword: String {
            "text_input_end_icon"
        }
        case errorHintLabelIdentifier = "textinput_error"
        case errorMassageViewTitle = "loginErrorMsg1"
        case errorMassageViewSubTitle = "loginErrorMsg2"
    }
}

extension VFGLoginPhoneViewController {
    public enum PhoneAccessibilityIds: String {
        case phoneTextField = "loginPhoneTxt"
        case errorHintLabelIdentifier = "textinput_error"
        case errorMassageViewTitle = "loginErrorNumberMsg1"
    }
}

extension VFGLoginVerification {
    public enum MessageAccessibilityIds: String {
        case errorMassageViewTitle = "loginErrorMsg1"
    }
}
