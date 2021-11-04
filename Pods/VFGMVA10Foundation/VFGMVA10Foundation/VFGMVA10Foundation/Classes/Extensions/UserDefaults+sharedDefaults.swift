//
//  UserDefaults+sharedDefaults.swift
//  VFGMVA10Foundation
//
//  Created by Moustafa Hegazy on 02/03/2021.
//

import Foundation

extension UserDefaults {
    // swiftlint:disable:next convenience_type
    private struct Keys {
        static let msisdn = "msisdn"
    }

    public var msisdn: String {
        get {
            return read(forKey: Keys.msisdn) ?? ""
        }
        set {
            save(item: newValue, forKey: Keys.msisdn)
        }
    }
}
