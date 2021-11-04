//
//  VFGAccount.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 12/15/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

open class VFGAccount: Codable {
    public var name: String
    public var imageName: String?
    public var msisdn: String
    public var type: VFGUserType?

    public init(name: String, imageName: String? = nil, msisdn: String = "", type: VFGUserType = .payM) {
        self.name = name
        self.imageName = imageName
        self.msisdn = msisdn
        self.type = type
    }
}
