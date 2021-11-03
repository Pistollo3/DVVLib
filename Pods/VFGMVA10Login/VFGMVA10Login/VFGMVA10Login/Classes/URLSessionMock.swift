//
//  URLSessionMock.swift
//  VFGLogin
//
//  Created by Atta Ahmed on 12/19/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

class URLSessionMock: URLSessionProtocol {
    /// you may use this for testing the delegate method
    weak var sessionDelegate: VFGNetworkProgressDelegate?
    init(delegate: VFGNetworkProgressDelegate? = nil) {
        self.sessionDelegate = delegate
    }
    var urlSessionDataTaskMock = URLSessionDataTaskMock()
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return urlSessionDataTaskMock
    }
    func downloadTask(
        with url: URL,
        completionHandler: @escaping DownloadTaskResult
    ) -> URLSessionDownloadTaskProtocol {
        return URLSessionDownloadTask()
    }

    func uploadTask(
        with request: URLRequest,
        from data: Data,
        completionHandler: @escaping DataTaskResult
    ) -> URLSessionUploadTaskProtocol {
        return URLSessionUploadTask()
    }
    func dataTask(
        with url: URL,
        completionHandler: @escaping URLSessionMock.DataTaskResult
    ) -> URLSessionDataTaskProtocol {
        do {
            let data = try Data(contentsOf: url)
            let succesResponse = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)
            completionHandler(data, succesResponse, nil)
        } catch {
            completionHandler(nil, nil, VFGNetworkError.serverNoData)
        }
        return urlSessionDataTaskMock
    }
}
class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    var progress = Progress()

    func resume() {
    }
    func suspend() {
    }
    func cancel() {
    }
}
