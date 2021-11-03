//
//  UserDefaults+Codable.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 12/16/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UserDefaults {
    public func save<T: Codable>(item: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(item)
            set(data, forKey: key)
        } catch let error {
            VFGDebugLog("Failed to encode with error \(error)")
        }
    }

    public func read<T: Codable>(forKey key: String) -> T? {
        if let savedObj = object(forKey: key) as? Data {
            do {
                let restoredItem = try JSONDecoder().decode(T.self, from: savedObj)
                return restoredItem
            } catch let error {
                VFGDebugLog("Failed to decode with error \(error)")
                return nil
            }
        }
        return nil
    }
}
