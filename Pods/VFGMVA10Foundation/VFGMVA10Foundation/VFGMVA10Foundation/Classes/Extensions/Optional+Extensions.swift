//
//  Optional+Extensions.swift
//  VFGMVA10Foundation
//
//  Created by Erdem ILDIZ on 26.07.2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public protocol DefaultValue {
    associatedtype DefaultType: DefaultValue where DefaultType.DefaultType == Self
    static var defaultValue: DefaultType { get }
}

public extension Optional where Wrapped: DefaultValue, Wrapped.DefaultType == Wrapped {
    var required: Wrapped {
        defer {
            if self == nil {
                assertionFailure("Value can not be nil because you try to unwrap value")
            }
        }
        return valueOrDefault
    }

    var valueOrDefault: Wrapped {
        guard let notNilSelf = self else {
            return Wrapped.defaultValue
        }
        return notNilSelf
    }
}

// swiftlint:disable force_unwrapping
public extension Optional {
    var required: Wrapped {
        guard let notNilSelf = self else {
            return self!
        }
        return notNilSelf
    }
}

public extension Optional where Wrapped == String {
    var isBlank: Bool {
        if let unwrapped = self {
            return unwrapped.isBlank
        } else {
            return true
        }
    }
}
