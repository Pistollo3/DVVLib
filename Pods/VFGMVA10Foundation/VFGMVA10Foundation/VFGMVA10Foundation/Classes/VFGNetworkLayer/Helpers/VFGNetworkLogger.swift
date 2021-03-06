//
//  NetworkLogger.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 10/15/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

enum VFGNetworkLogger {
    static func log(request: URLRequest) {
        VFGDebugLog("\n - - - - - - - - - - Request - - - - - - - - - - \n")
        defer { VFGDebugLog("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        var logOutput = """
        \(urlAsString) \n\n
        \(method) \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        for queryItem in urlComponents?.queryItems ?? [] {
            logOutput += "\(queryItem.name): \(String(describing: queryItem.value)) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        VFGDebugLog(logOutput)
    }

    static func log(response: HTTPURLResponse) {
        VFGDebugLog("\n - - - - - - - - - - Response - - - - - - - - - - \n")
        defer { VFGErrorLog("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlAsString = response.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"

        var logOutput = """
        URL:\(urlAsString) \n\n
        \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        logOutput += "\nResponse_Headers: "
        for (key, value) in response.allHeaderFields {
            logOutput += "\(key): \(value) \n"
        }
        let statusCode = String(response.statusCode)
        logOutput += "\nResponse_statusCode: \(statusCode)"
        let mimeType = response.mimeType ?? ""
        logOutput += "\nResponse_mimeType: \(mimeType)"
        let desctription = response.description
        logOutput += "\nResponse: \(desctription)"
        VFGDebugLog(logOutput)
    }

    static func log(jsonResponse: String) {
        VFGDebugLog("\n - - - - - - - - - - Response Json Data - - - - - - - - - - \n")
        defer { VFGDebugLog("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        VFGDebugLog(jsonResponse)
    }
}
