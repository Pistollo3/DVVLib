//
//  VFGLoginMultipleAccountsProtocol.swift
//  VFGMVA10Login
//
//  Created by Hussien Gamal Mohammed Fahmy on 13/04/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation
public protocol VFGLoginAccountsListProtocol: class {
    func didSelect(_ account: VFGAccount, at index: Int)
    func add(_ account: VFGAccount)
    func delete(_ account: VFGAccount, completion: @escaping (_ success: Bool?, _ showContactSupportButton: Bool?) -> Void)
    func retrieveSavedAccounts() -> [VFGAccount]
    func closeButtonAction()
    func contactSupportAction()
    var tobiDelegate: VFGTobiHandlerDelegate? { get set }
    var isCloseButtonHidden: Bool { get }
}

public extension VFGLoginAccountsListProtocol {
    var isCloseButtonHidden: Bool { true }
    func closeButtonAction() {}
}
