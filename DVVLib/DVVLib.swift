//
//  DVVLib.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 02/11/21.
//

import Foundation
import VFGMVA10Foundation
import VFGMVA10Login

public class DVVLib: VFGLoginManagerDelegate {
    public func present(viewController: UIViewController) {
        let mainStoryboard = UIStoryboard(name: "AfterLoginVC", bundle: nil)
        self.present(viewController: mainStoryboard.instantiateInitialViewController()!)
    }
    
    public func onFinish(result: VFGLoginResult, dismiss viewController: UIViewController?) {
        let mainStoryboard = UIStoryboard(name: "AfterLoginVC", bundle: nil)
        self.present(viewController: mainStoryboard.instantiateInitialViewController()!)
    }
    
    public static let shared = DVVLib()
    public static func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    private static func sub(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
    
    public static func doLogin() {
        _ = VFGLoginManager(softLoginProtocol: VFGSoftLogin(), upfrontLoginProtocol: nil, seamlessLoginProtocol: nil, fixedLineLoginProtocol: nil, loginAccountsListProtocol: nil, loginManagerDelegate: self.shared, isTobiEnabled: false)
    }
}
