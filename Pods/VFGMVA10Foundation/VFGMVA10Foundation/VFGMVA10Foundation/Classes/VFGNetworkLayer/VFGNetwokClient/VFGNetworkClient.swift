//
//  VFGNetworkClient.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 10/17/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
public typealias CurrentTask = (request: VFGRequestProtocol?, task: URLSessionDataTaskProtocol?)
var observation: [Int: NSKeyValueObservation] = [:]
// Exposed Network Client that will be inherited
open class VFGNetworkClient: VFGNetworkClientProtocol {
    var networkProgressDelegate: VFGNetworkProgressDelegate? {
        return session.sessionDelegate
    }
    var headerFields: [AnyHashable: Any]?
    public var runningTasks: [CurrentTask] = []
    open var timeout: TimeInterval { return NetworkDefaults.timeOut }
    public var baseUrl: String
    public var headers: [String: String]? { return nil }
    public var session: URLSessionProtocol
    public var authClientProvider: AuthTokenProvider?
    public init(baseURL: String, session: URLSessionProtocol = URLSession.shared) {
        self.baseUrl = baseURL
        self.session = session
    }
}
