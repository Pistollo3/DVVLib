//
//  VFGUser.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 11/3/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

public protocol VFGUserDataPersistingDelegate: AnyObject {
    func saveType(type: VFGUserType)
    func retrieveType() -> VFGUserType
    func saveAccounts(accounts: [VFGAccount])
    func retrieveAccounts() -> [VFGAccount]
}

open class VFGUser {
    public static let shared = VFGUser()
    public weak var delegate: VFGUserDataPersistingDelegate?

    let userLoginTypeKey = "VFGUserLoginType"
    let selectedAccountKey = "VFGUserSelectedAccount"

    private init() {}

    var tempType: VFGUserType = .payM
    public var type: VFGUserType {
        get {
            delegate?.retrieveType() ?? tempType
        }
        set {
            delegate?.saveType(type: newValue)
            tempType = newValue
        }
    }

    var tempAccounts: [VFGAccount] = []
    public var accounts: [VFGAccount] {
        get {
            delegate?.retrieveAccounts() ?? tempAccounts
        }
        set {
            delegate?.saveAccounts(accounts: newValue)
            tempAccounts = newValue
        }
    }

    public var relatedAccount: [VFGAccount] = []
    public var loginType: String? {
        get {
            UserDefaults.standard.string(forKey: userLoginTypeKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userLoginTypeKey)
        }
    }

    public func selectAccount(at index: Int) {
        UserDefaults.standard.set(index, forKey: selectedAccountKey)
    }

    public func selectedAccount() -> VFGAccount? {
        let index = UserDefaults.standard.integer(forKey: selectedAccountKey)
        guard !accounts.isEmpty,
            0..<accounts.count ~= index else { return nil }
        return accounts[index]
    }

    public func switchTo(
        account: VFGAccount,
        delay: Double = 3,
        completion: @escaping () -> Void
    ) {
        guard let index = VFGUser.shared.accounts.firstIndex(where: { $0.name == account.name }) else {
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else {
                completion()
                return
            }

            self.selectAccount(at: index)
            completion()
        }
    }
}
