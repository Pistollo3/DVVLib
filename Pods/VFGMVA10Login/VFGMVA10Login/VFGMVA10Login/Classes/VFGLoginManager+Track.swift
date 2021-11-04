//
//  VFGLoginManager+Track.swift
//  VFGMVA10Login
//
//  Created by Mohamed Abd ElNasser on 6/28/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import VFGMVA10Foundation

extension VFGLoginManager {
    static func trackView(screenType: VFGLoginScreensType) {
        let journeyType = JourneyType.login.rawValue
        let parameters: [String: String] = [
            VFGAnalyticsKeys.journeyType: journeyType,
            VFGAnalyticsKeys.pageName: screenType.rawValue,
            VFGAnalyticsKeys.pageSection: journeyType
        ]

        VFGAnalyticsManager.trackView(parameters: parameters, bundle: .login)
    }

    static func trackEvent(
        screenType: VFGLoginScreensType,
        eventLabel: String,
        eventAction: EventAction = .onClick,
        eventCategory: EventCategory = .button
    ) {
        let journeyType = JourneyType.login.rawValue
        let parameters: [String: String] = [
            VFGAnalyticsKeys.journeyType: journeyType,
            VFGAnalyticsKeys.pageName: screenType.rawValue,
            VFGAnalyticsKeys.pageSection: journeyType,
            VFGAnalyticsKeys.eventAction: eventAction.rawValue,
            VFGAnalyticsKeys.eventCategory: eventCategory.rawValue,
            VFGAnalyticsKeys.eventLabel: eventLabel,
            VFGAnalyticsKeys.callType: "link"
        ]

        VFGAnalyticsManager.trackEvent(parameters: parameters)
    }
}
