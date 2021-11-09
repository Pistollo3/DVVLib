//
//  GHRequestManager.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 09/11/21.
//

import Foundation
import VFGMVA10Foundation

struct UserResponseData: Codable {
    let data: UserData
}

struct UserData: Codable {
    let gender: String
    let id: Int
    let name: String
}


public class GHGoogleManager {
    public let shared = GHGoogleManager()
    
    private let myNetworkClient = VFGNetworkClient(baseURL: " https://gorest.co.in/public/v1/")
    
    public func makeRequest() {
        let request = VFGRequest(path: "/users", httpMethod: .get, httpTask: .request, headers: nil, isAuthenticationNeededRequest: false, cachePolicy: .reloadIgnoringLocalCacheData)
        myNetworkClient.executeData(request: request, model: UserResponseData.self, completion: { value in
            print("COMPLETED!  \(value)")
        })
    }
    
    
    
    
}
