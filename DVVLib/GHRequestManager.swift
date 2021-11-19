//
//  GHRequestManager.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 09/11/21.
//

//MVA10 Network Layer Test class

import Foundation
import VFGMVA10Foundation

public typealias HTTPHeaders = [String: String]
public typealias VFGParameters = [String: Any]

struct UserPosts : Codable {
    let body : String?
    let id : Int?
    let title : String?
    let userId : Int?
}

public class GHGoogleManager {
    public static var shared = GHGoogleManager()
    
    private let myNetworkClient = VFGNetworkClient(baseURL: "https://jsonplaceholder.typicode.com")
    
    public func makeRequest() {
        let request = VFGRequest(path: "/posts",
                                        httpMethod: .get,
                                        httpTask: .requestWithParameters(
                                               bodyParameters: nil,
                                               bodyEncoding: .urlEncoding,
                                            urlParameters: [(key: "userId", value: "1")]),
                                        headers: nil,
                                        isAuthenticationNeededRequest: true,
                                        cachePolicy: .reloadIgnoringLocalCacheData)
        myNetworkClient.executeData(request: request, model: [UserPosts].self,progressClosure: { value in
            // percentage of the progress from 0 to 1
            }) { result in
            switch result {
            case .success(let model):
                print("SUCCESS!! \(model)")
            case .failure(let error):
                print("ERROR!! \(error)")
            }
          }
    }
    
    
    
    
}
