//
//  VFGTealiumAnalyticsProvider.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed ELMeseery on 6/19/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

public class VFGTealiumAnalyticsProvider: NSObject, VFGAnalyticsProvider {
    public var identifier: String
    var tealiumInstance: AnyObject?

    typealias ConfigurationWithAccountType = @convention(c)(AnyClass?, Selector, String, String, String) -> NSObject?
    typealias NewInstanceFunctionType = @convention(c)(AnyClass?, Selector, String, NSObject?) -> NSObject?

    private let configurationMethodName = NSSelectorFromString("configurationWithAccount:profile:environment:")
    private static let tealiumClass: AnyClass? = NSClassFromString("Tealium")

    init(identifier: String) {
        self.identifier = identifier
        super.init()
    }

    public convenience init?(account: String, profile: String, environment: String, identifier: String) {
        self.init(identifier: identifier)

        guard let tealiumInstance = newInstance(for: identifier, account, profile, environment) else {
            return nil
        }

        self.tealiumInstance = tealiumInstance
    }

    private func newInstance(
        for key: String,
        _ account: String,
        _ profile: String,
        _ environment: String
    ) -> NSObject? {
        let tealiumConfig = configure(with: account, profile, environment)

        guard let newInstanceMethodPointer = class_getClassMethod(
            VFGTealiumAnalyticsProvider.tealiumClass,
            NSSelectorFromString("newInstanceForKey:configuration:")) else {
                return nil
        }

        let newInstanceMethodIMP = method_getImplementation(newInstanceMethodPointer)

        guard let tealiumInstance: NSObject = unsafeBitCast(
            newInstanceMethodIMP,
            to: NewInstanceFunctionType.self
            )(
                VFGTealiumAnalyticsProvider.tealiumClass,
                configurationMethodName,
                identifier,
                tealiumConfig
            ) else {
                return nil
        }

        return tealiumInstance
    }

    private func configure(with account: String, _ profile: String, _ environment: String) -> NSObject? {
        guard let configurationClassName: AnyClass = NSClassFromString("TEALConfiguration"),
            let method: Method = class_getClassMethod(configurationClassName, configurationMethodName) else {
                VFGErrorLog("unable to initialize tealium - no config class")
                return nil
        }

        let methodIMP = method_getImplementation(method)

        guard let tealiumConfiguration: NSObject = unsafeBitCast(
            methodIMP,
            to: ConfigurationWithAccountType.self
            )(
                configurationClassName,
                configurationMethodName,
                account,
                profile,
                environment) else {
                    return nil
        }

        return tealiumConfiguration
    }

    public func track(event: String, parameters: [String: Any]?) {
        _ = tealiumInstance?.perform(
            NSSelectorFromString("trackEventWithTitle:dataSources:"),
            with: event,
            with: parameters)
    }
}

extension VFGTealiumAnalyticsProvider {
    class func instance(for key: String) -> NSObject? {
        let instanceForKeyMethodName = NSSelectorFromString("instanceForKey:")

        if let instanceForKeyMethodPointer = class_getClassMethod(tealiumClass, instanceForKeyMethodName) {
            let instanceForKeyMethodIMP = method_getImplementation(instanceForKeyMethodPointer)
            typealias InstanceForKeyFunctionType = @convention(c)(AnyClass?, Selector, String) -> NSObject
            return unsafeBitCast(instanceForKeyMethodIMP, to: InstanceForKeyFunctionType.self)(
                tealiumClass,
                instanceForKeyMethodName,
                key)
        } else {
            return nil
        }
    }
}
