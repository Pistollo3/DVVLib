//
//  LanguageModel.swift
//  VFGMVA10Framework
//
//  Created by Yahya Saddiq on 01/09/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

public struct LanguageModel: Decodable {
    public var name: String
    public let imageName: String
    public let identifier: String
    public var isCurrentLanguage: Bool?

    public init(name: String, imageName: String, identifier: String, isCurrentLanguage: Bool = false) {
        self.name = name.localized()
        self.imageName = imageName
        self.identifier = identifier
        self.isCurrentLanguage = isCurrentLanguage
    }

    enum CodingKeys: String, CodingKey {
        case name
        case imageName
        case identifier
        case isCurrentLanguage
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = (try container.decode(String.self, forKey: .name)).localized()
        imageName = try container.decode(String.self, forKey: .imageName)
        identifier = try container.decode(String.self, forKey: .identifier)
        isCurrentLanguage = try? container.decode(Bool.self, forKey: .isCurrentLanguage)
    }

    public mutating func setCurrentLanguage(currentIdentifier: String) {
        isCurrentLanguage = identifier == currentIdentifier
    }
}
