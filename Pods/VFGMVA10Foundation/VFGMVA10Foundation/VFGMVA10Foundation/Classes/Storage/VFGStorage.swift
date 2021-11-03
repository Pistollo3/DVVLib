//
//  VFGStorage.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Zaki on 17/02/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/// Store & retrieve any codable object
public class VFGStorage {
    /// The stored data priority
    public enum Priority: Int {
        case permanently = 0
        case high = 1
        case medium = 2
        case low = 3
    }

    private var saveDuration: TimeInterval?
    private var lifetime: TimeInterval?
    let context = VFGStorageCoreDataStack().persistentContainer.viewContext
    var storedElements: [VFGStoredItem]?
    public init() {}

    /**
    Configure VFGStorage
    - Parameters:
        - saveDuration: The duration after which data will be moved from memory to disk
        - lifetime: time after which data will be removed from disk
    */
    public func configure(saveDuration: TimeInterval = 30, lifetime: TimeInterval = 30) {
        self.saveDuration = saveDuration
        self.lifetime = lifetime
        // check for invalid caches
        removeExpiredCaches()
    }
    /**
    Save data
    - Parameters:
        - key: a string identifier
        - model: data that will be stored, it should conform to codable protocol
        - lifeTime: (optional) time after which data will be removed from disk, this will override the value in the configure function
        - priority: (default medium) priority category in which to save data
        - shouldExtendTimeIfAccessed: boolean to extend the validity of the data if its accessed
        - completion: a closure that will be called after saving the data to disk
    */
    public func save<T: Codable>(withKey key: String, model: T, lifetime: TimeInterval? = nil, priority: Priority = .medium, shouldExtendTimeIfAccessed: Bool = false, completion: ((Bool) -> Void)? = nil) {
        do {
            let data = try JSONEncoder().encode(model.self)
            let lifetime = lifetime ?? self.lifetime ?? 30
            let timer = lifetime + Date().timeIntervalSince1970
            let fetch = VFGStoredItem.fetchRequest() as NSFetchRequest<VFGStoredItem>
            let predicate = NSPredicate(format: "key = %@", key)
            fetch.predicate = predicate
            if let storedElements = try? context.fetch(fetch), !storedElements.isEmpty {
                // this means it adds to an existing object so we will remove the old one
                deleteItem(storedElements)
            }
            let cachingElement = VFGStoredItem(context: context)
            let cachingData = VFGStoredItemData(context: context)
            cachingData.data = data
            cachingElement.fillData(
                key: key,
                data: cachingData,
                timer: timer,
                lifetime: lifetime,
                priority: priority.rawValue,
                shouldExtendTimeIfAccessed: shouldExtendTimeIfAccessed)
            DispatchQueue.main.asyncAfter(deadline: .now() + (self.saveDuration ?? 0)) { [weak self] in
                guard let self = self else { return }
                // save in database
                self.flush()
                completion?(true)
            }
        } catch {
            completion?(false)
        }
    }

    /**
    Read model that conforms to codable protocol
    - Parameters:
        - key: a string identifier
        - model: type of the model that will be retrieved, it should conform to codable protocol
    - returns: model of type T
    */
    public func read<T: Codable>(model: T.Type, withKey key: String) -> T? {
        let fetch = VFGStoredItem.fetchRequest() as NSFetchRequest<VFGStoredItem>
        let predicate = NSPredicate(format: "key = %@", key)
        fetch.predicate = predicate
        storedElements = try? context.fetch(fetch)
        guard let storedElement = storedElements?.first else { return nil }

        // check if expired caches
        if storedElement.timer < Date().timeIntervalSince1970 {
            context.delete(storedElement)
            return nil
        }
        do {
            guard let data = storedElement.storedItemData?.data else { return nil }
            // if shouldExtendTimeIfAccessed is true it reset the lifeTime to start again
            if storedElement.shouldExtendTimeIfAccessed {
                storedElement.timer = storedElement.lifetime + Date().timeIntervalSince1970
                DispatchQueue.main.asyncAfter(deadline: .now() + (self.saveDuration ?? 0)) { [weak self] in
                    guard let self = self else { return }
                    // save in database
                    self.flush()
                }
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }

    // remove key from the data base
    fileprivate func deleteItem(_ items: [VFGStoredItem]?) {
        items?.forEach { item in
            context.delete(item)
        }
    }

    /// remove key from database
    /// - Parameter key: a string identifier
    public func remove(withKey key: String) {
        let fetch = VFGStoredItem.fetchRequest() as NSFetchRequest<VFGStoredItem>
        let predicate = NSPredicate(format: "key = %@", key)
        fetch.predicate = predicate
        let items = try? context.fetch(fetch)
        deleteItem(items)
    }

    /// save to database immediately
    public func flush() {
        try? context.save()
    }

    /// remove all stored data
    public func removeAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "VFGStoredItem")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            VFGErrorLog(error.localizedDescription)
        }
    }
    /// remove all data stored which has the given priority or lower
    /// - Parameter priority: stored data priority
    public func remove(withPriority priority: Priority) {
        let fetch = VFGStoredItem.fetchRequest() as NSFetchRequest<VFGStoredItem>
        let predicate = NSPredicate(format: "priority => %i", priority.rawValue)
        fetch.predicate = predicate
        let items = try? context.fetch(fetch)
        deleteItem(items)
    }

    public func removeExpiredCaches() {
        let fetch = VFGStoredItem.fetchRequest() as NSFetchRequest<VFGStoredItem>
        storedElements = try? context.fetch(fetch)
        storedElements?.forEach { item in
            if item.timer < Date().timeIntervalSince1970 {
                context.delete(item)
            }
        }
    }
}
