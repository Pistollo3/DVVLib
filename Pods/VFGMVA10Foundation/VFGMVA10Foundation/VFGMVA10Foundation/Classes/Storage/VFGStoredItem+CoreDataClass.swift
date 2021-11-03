//
//  VFGStoredItem+CoreDataClass.swift
//  
//
//  Created by Mohamed Zaki on 18/02/2021.
//
//

import Foundation
import CoreData

// swiftlint:disable function_parameter_count
public class VFGStoredItem: NSManagedObject {
    func fillData(key: String, data: VFGStoredItemData, timer: TimeInterval, lifetime: TimeInterval, priority: Int, shouldExtendTimeIfAccessed: Bool) {
        self.key = key
        self.storedItemData = data
        self.timer = timer
        self.lifetime = lifetime
        self.priority = Int64(priority)
        self.shouldExtendTimeIfAccessed = shouldExtendTimeIfAccessed
    }
}
