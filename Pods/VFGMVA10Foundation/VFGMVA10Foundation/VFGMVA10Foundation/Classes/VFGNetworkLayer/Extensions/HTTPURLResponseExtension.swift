//
//  HTTPURLResponseExtension.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 10/17/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

extension HTTPURLResponse: HTTPURLResponseProtocol {
    public func handleNetworkResponse() -> VFGNetworkError? {
        switch self.statusCode {
        case 200...299: return nil
        case 400:       return VFGNetworkError.serverBadRequest
        case 401...499: return VFGNetworkError.serverAuthenticationError
        case 500...599: return VFGNetworkError.serverError
        case 600: return VFGNetworkError.serverOutdated
        default: return VFGNetworkError.serverFailed
        }
    }
}
