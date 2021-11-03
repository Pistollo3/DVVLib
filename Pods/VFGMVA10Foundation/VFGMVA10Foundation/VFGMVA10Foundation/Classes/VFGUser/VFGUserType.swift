//
//  VFGUserType.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 11/10/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public struct VFGUserType: Equatable, Codable {
    public var rawValue: String

    // Default Types
    public static let payM = VFGUserType(rawValue: "payM")
    public static let payG = VFGUserType(rawValue: "payG")
    public static let soho = VFGUserType(rawValue: "soho")

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public static func == (lhs: VFGUserType, rhs: VFGUserType) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    public static func != (lhs: VFGUserType, rhs: VFGUserType) -> Bool {
        lhs.rawValue != rhs.rawValue
    }

    public init(from decoder: Decoder) throws {
        self = try VFGUserType(rawValue: decoder.singleValueContainer().decode(String.self))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
