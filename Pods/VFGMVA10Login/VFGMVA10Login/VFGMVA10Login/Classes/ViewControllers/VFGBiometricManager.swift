//
//  VFGBiometricManager.swift
//  VFGMVA10Login
//
//  Created by Moustafa Hegazy on 16/08/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import VFGMVA10Foundation
import LocalAuthentication

final public class BiometricManager {
    internal var authenticationContext = LAContext()

    public func canEvaluate() -> (Bool, Error?) {
        var error: NSError?
        let authenticateState = authenticationContext
            .canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
        return (authenticateState, error)
    }

    public func authenticate(completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        let (canEvaluateState, error) = canEvaluate()

        if canEvaluateState {
            authenticationContext
                .evaluatePolicy(
                    LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                    localizedReason: "Need to access credentials.") { success, error in
                    DispatchQueue.main.async {
                        if error != nil {
                            completion(false, error)
                        } else {
                            completion(success, nil)
                        }
                    }
                }
        } else {
            completion(canEvaluateState, error)
        }
    }
}
