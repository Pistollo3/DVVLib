//
//  VFGBadgesTracker.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 11/15/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

public protocol VFGBadgesTrackerDelegate: class {
    func notifyBadgeDidUpdate(with badgeID: String, model: BadgeModel)
}

open class VFGBadgesTracker {
    public static let shared = VFGBadgesTracker()
    public weak var delegate: VFGBadgesTrackerDelegate?
    var badgesValues: [String: BadgeModel] = [:]

    private init() {}

    public func updateBadge(with badgeID: String, model: BadgeModel) {
        VFGBadgesTracker.shared.badgesValues[badgeID] = model
        NotificationCenter.default.post(
            name: .VFGBadgesTrackerID,
            object: self,
            userInfo: badgesValues
        )
        delegate?.notifyBadgeDidUpdate(with: badgeID, model: model)
    }
}
