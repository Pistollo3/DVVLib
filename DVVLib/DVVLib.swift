//
//  DVVLib.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 02/11/21.
//

import Foundation
import VFGMVA10Login

public class DVVLib: VFGLoginManagerDelegate {
    public static var shared = DVVLib()
    
    public func present(viewController: UIViewController) {
        print("present")
        UIApplication.topViewController()?.present(viewController, animated: true)
    }
    
    public func onFinish(result: VFGLoginResult, dismiss viewController: UIViewController?) {
        print("OOK")
        switch result {
                  // userData is a [String: String] contains data about logged in user .e.g the type of user (payM, PAYG, ...).
                case .success(let userData):
                    print("success")
                case .fail:
                    print("Fail")// Implement failure logic here
                }
    
    }
    
    public static func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    private static func sub(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
    
    public static func doLogin() {
        let manager = VFGLoginManager.init(softLoginProtocol: VFGSoftLogin(), upfrontLoginProtocol: nil, seamlessLoginProtocol: nil, fixedLineLoginProtocol: nil, loginAccountsListProtocol: nil, loginManagerDelegate: shared, isTobiEnabled: true)
        manager.login()
    }
}
