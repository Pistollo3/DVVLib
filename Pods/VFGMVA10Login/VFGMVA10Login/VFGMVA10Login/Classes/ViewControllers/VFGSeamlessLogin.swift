//
//  VFGSeamlessLogin.swift
//  VFGLogin
//
//  Created by Mohamed Sayed on 7/29/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation

enum SeamlessLoginError: Error {
    case cellularFail
    case wifi
    case offline
    case delegateNotSet
}

/**
Seamless login
- loginSilently: Will check seamlessAPIImplementation if connection is cellular
otherwise will navigate to another login flow(upfront or soft)
*/
class VFGSeamlessLogin {
    weak var delegate: VFGSeamlessLoginProtocol?
    weak var internalDelegate: VFGSeamlessInternalProtocol?
    var myReachability: VFGReachabilityProtocol? = VFGReachability()

    init(delegate: VFGSeamlessLoginProtocol?) {
        self.delegate = delegate
    }

    func loginSilently() {
        guard let reachability = myReachability,
            let delegate = delegate else {
                internalDelegate?.seamlessCompletion(result: .fail(error: SeamlessLoginError.delegateNotSet))
                return
        }

        switch reachability.connection {
        case .cellular:
            delegate.seamlessAPIImplementation { result in
                internalDelegate?.seamlessCompletion(result: result)
            }
        case .wifi:
            internalDelegate?.seamlessCompletion(result: .fail(error: SeamlessLoginError.wifi))
        case .none:
            internalDelegate?.seamlessCompletion(result: .fail(error: SeamlessLoginError.offline))
        }
    }
}
