//
//  VFGNetworkClient+Download.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 3/23/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

extension VFGNetworkClient {
    public func download(
        url: String,
        progressClosure: VFGNetworkProgressClosure? = nil,
        completion: @escaping VFGNetworkDownloadClosure
    ) {
        let currentTask: URLSessionDownloadTaskProtocol
        let baseURL = URL(string: url)

        if let baseURL = baseURL {
            currentTask = session.downloadTask(with: baseURL) { location, response, error in
                DispatchQueue.main.async {
                    completion(location, response, error)
                }
            }
            currentTask.resume()
            networkProgressDelegate?.addTask(downloadTask: currentTask, progressClosure: progressClosure)
        }
    }
}
