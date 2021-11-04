//
//  VFGLogin+Init.swift
//  VFGLogin
//
//  Created by Tomasz Czyżak on 23/07/2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import VFGMVA10Foundation
import UIKit

extension VFGLoginEmail {
    class func instance() -> VFGLoginEmail {
        return VFGLoginEmail.instance(
            from: VFGLoginBaseViewController.storyBoardName,
            bundle: Bundle.login)
    }
}

extension VFGLoginPhoneViewController {
    class func instance() -> VFGLoginPhoneViewController {
        return VFGLoginPhoneViewController.instance(
            from: VFGLoginBaseViewController.storyBoardName,
            bundle: Bundle.login)
    }
}

extension VFGLoginVerification {
    class func instance() -> VFGLoginVerification {
        return VFGLoginEmail.instance(
            from: VFGLoginBaseViewController.storyBoardName,
            bundle: Bundle.login)
    }
}
extension VFGFixedLineUpfrontLogin {
    class func instance() -> VFGFixedLineUpfrontLogin {
        return VFGFixedLineUpfrontLogin.instance(
            from: VFGFixedLineUpfrontLogin.storyBoardName,
            bundle: Bundle.login)
    }
}

extension VFGLoginBaseViewController {
    class func instance() -> VFGLoginBaseViewController {
        return VFGLoginBaseViewController.instance(
            from: VFGLoginBaseViewController.storyBoardName,
            bundle: Bundle.login)
    }
}

extension VFGChooseAccountTypeViewController {
    class func instance() -> VFGChooseAccountTypeViewController {
        return VFGChooseAccountTypeViewController.instance(
            from: VFGLoginBaseViewController.storyBoardName,
            bundle: Bundle.login)
    }
}

extension VFGLoginAccountsList {
    class func instance() -> VFGLoginAccountsList {
        return VFGLoginAccountsList.instance(
            from: VFGLoginAccountsList.storyBoardName,
            bundle: Bundle.login)
    }
}
