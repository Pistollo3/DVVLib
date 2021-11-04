//
//  VFGAnalyticsManager.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed ELMeseery on 6/19/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

/**
`AnalyticsManager` is a class taking care of managing your different analytics providers.
No matter how many providers you use, it will take care of configuring every one of them
and notifying them on every event you wish to track within your app.
*/

open class VFGAnalyticsManager {
    var providers: [VFGAnalyticsProvider]
    private let queue: OperationQueue
    static var shared = VFGAnalyticsManager()

    private init() {
        providers = []
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .background
    }

    public class func add(_ providers: [VFGAnalyticsProvider], completion: (() -> Void)? = nil) {
        VFGAnalyticsManager.shared.add(providers, completion: completion)
    }

    private func add(_ providers: [VFGAnalyticsProvider], completion: (() -> Void)? = nil) {
        queue.addOperation { [weak self] in
            guard let `self` = self else { return }
            self.providers.append(contentsOf: providers)
            completion?()
        }
    }

    public class func remove(_ provider: VFGAnalyticsProvider, completion: (() -> Void)? = nil) {
        VFGAnalyticsManager.shared.remove(provider, completion: completion)
    }

    private func remove(_ provider: VFGAnalyticsProvider, completion: (() -> Void)? = nil) {
        queue.addOperation { [weak self] in
            guard let `self` = self else { return }
            self.providers.removeAll { $0.identifier == provider.identifier }
            completion?()
        }
    }

    public class func reset(completion: (() -> Void)? = nil) {
        VFGAnalyticsManager.shared.reset(completion: completion)
    }

    private func reset(completion: (() -> Void)? = nil) {
        queue.addOperation { [weak self] in
            guard let `self` = self else { return }
            self.providers.removeAll()
            completion?()
        }
    }

    @available(*, deprecated, message: "Use trackView and trackEvent instead")
    open class func track(event: String, parameters: [String: String]? = nil, completion: (() -> Void)? = nil) {
        VFGAnalyticsManager.shared.track(event: event, parameters: parameters, completion: completion)
    }

    open class func trackView(
        event: String = "page_view",
        parameters: [String: String] = [:],
        bundle: Bundle?,
        completion: (() -> Void)? = nil
    ) {
        var finalParameters = parameters
        if let bundle = bundle,
            Bundle.allVFGBundles.contains(bundle) {
                finalParameters["component_owner"] = "OnePlatform"
                finalParameters["component_name"] = bundle.applicationName.lowercased()
                    .replacingOccurrences(of: "vfgmva10", with: "")
                finalParameters["component_version"] = bundle.appShortVersion
        }
        VFGAnalyticsManager.shared.track(event: event, parameters: finalParameters, completion: completion)
    }

    open class func trackEvent(
        event: String = "ui-interaction",
        parameters: [String: String] = [:],
        completion: (() -> Void)? = nil
    ) {
        VFGAnalyticsManager.shared.track(event: event, parameters: parameters, completion: completion)
    }

    private func track(event: String, parameters: [String: Any]? = nil, completion: (() -> Void)? = nil) {
        guard !providers.isEmpty else {
            VFGErrorLog("Unable to track - no available providers")
            completion?()
            return
        }
        queue.addOperation { [weak self] in
            guard let `self` = self else { return }
            self.providers.forEach { provider in
                provider.track(event: event, parameters: parameters)
            }
            completion?()
        }
    }
}

public enum JourneyType: String {
    case onboarding = "Onboarding"
    case dashboard = "Dashboard"
    case login = "Login"
    case billing = "Billing"
}

public enum EventAction: String {
    case onClick = "OnClick"
    case onScroll = "OnScroll"
    case swipe = "Swipe"
}

public enum EventCategory: String {
    case button = "Button"
    case carousel = "Carousel"
}
