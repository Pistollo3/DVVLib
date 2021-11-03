//
//  UnkeyedEncoderContainer+DictionaryAny.swift
//  VFGMVA10Framework
//
//  Created by Hussien Gamal Mohammed on 11/23/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
public struct JSONCodingKeys: CodingKey {
    public var stringValue: String

    public init?(stringValue: String) {
        self.stringValue = stringValue
    }

    public var intValue: Int?

    public init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}

public extension UnkeyedEncodingContainer {
    mutating func encode(anyObject object: Any) throws {
        if let objectAsBool = object as? Bool {
            try encode(objectAsBool)
        }
        if let objectAsString = object as? String {
            try encode(objectAsString)
        }
        if let objectAsDouble = object as? Double {
            try encode(objectAsDouble)
        }
        if let objectAsInt = object as? Int {
            try encode(objectAsInt)
        }
        if let objectAsFloat = object as? Float {
            try encode(objectAsFloat)
        }
        if let objectAsDictionary = object as? [String: Any] {
            try encode(dictionary: objectAsDictionary)
        }
        if let objectAsArrayAny = object as? [Any] {
            try encode(arrayAny: objectAsArrayAny)
        }
    }

    mutating func encode(dictionary: [String: Any]) throws {
        var nestedContainerObject = nestedContainer(keyedBy: JSONCodingKeys.self)
        try nestedContainerObject.encode(dictionary: dictionary)
    }

    mutating func encode(arrayAny: [Any]) throws {
        for object in arrayAny {
            try encode(anyObject: object)
        }
    }
}
