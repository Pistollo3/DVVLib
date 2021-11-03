//
//  Constants.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 10/17/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

public enum NetworkDefaults {
    public static let timeOut: TimeInterval = 10
    public static let httpMethod: HTTPMethod = .get
    public static let httpTask: HTTPTask = .request
    public static let httpHeaders: VFGHTTPHeaders? = nil
    public static let cashPolicy: VFGCachePolicy = .reloadIgnoringLocalCacheData
    public static let isAuthenticationNeeded = true
    public static let path: String = ""
    public static let workerQueue = DispatchQueue.global(qos: .default)
}
