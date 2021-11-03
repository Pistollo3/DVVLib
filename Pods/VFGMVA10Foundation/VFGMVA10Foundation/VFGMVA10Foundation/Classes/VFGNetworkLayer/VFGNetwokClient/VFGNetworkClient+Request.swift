//
//  VFGNetworkClient+Request.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 3/23/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

// MARK: - Request builder
extension VFGNetworkClient {
    open func buildRequest(
        from endPoint: VFGRequestProtocol,
        with headers: VFGHTTPHeaders,
        to baseURL: URL?
    ) throws -> URLRequest {
        guard let baseURL = baseURL else {
            throw VFGNetworkError.missingURL
        }

        var request = URLRequest(
            url: baseURL.appendingPathComponent(endPoint.path),
            cachePolicy: endPoint.cachePolicy,
            timeoutInterval: timeout)
        request.allHTTPHeaderFields = headers
        request.httpMethod = endPoint.httpMethod.rawValue

        do {
            switch endPoint.httpTask {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case let .requestWithParameters(
                bodyParameters,
                bodyEncoding,
                urlParameters):
                try configureParameters(
                    bodyParameters: bodyParameters,
                    bodyEncoding: bodyEncoding,
                    urlParameters: urlParameters,
                    request: &request)
            case let .requestWithParametersAndHeaders(
                bodyParameters,
                bodyEncoding,
                urlParameters,
                additionalHeaders):
                addAdditionalHeaders(additionalHeaders, request: &request)
                try configureParameters(
                    bodyParameters: bodyParameters,
                    bodyEncoding: bodyEncoding,
                    urlParameters: urlParameters,
                    request: &request)
            }
            return request
        } catch {
            throw error
        }
    }

    open func configureParameters(
        bodyParameters: VFGParameters?,
        bodyEncoding: VFGParameterEncoder,
        urlParameters: VFGParameters?,
        request: inout URLRequest
    ) throws {
        do {
            try bodyEncoding.encode(
                urlRequest: &request,
                bodyParameters: bodyParameters,
                urlParameters: urlParameters)
        } catch {
            throw error
        }
    }

    private func addAdditionalHeaders(_ additionalHeaders: VFGHTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    open func buildHeaders<T: Codable>(request: VFGRequestProtocol, completion: @escaping VFGNetworkCompletionDelegate<T>) -> VFGHTTPHeaders {
        var requestClientHeaders: VFGHTTPHeaders = headers ?? [:]
        if  request.isAuthenticationNeededRequest ?? false {
            authClientProvider?.requestAuthToken { token, error in
                guard let token = token?.first else {
                    if let error = error {
                        completion(.failure(error))
                    }
                    return
                }
                requestClientHeaders[token.key] = token.value
            }
        }
        request.headers?.forEach {
            requestClientHeaders[$0.key] = $0.value
        }
        return requestClientHeaders
    }
}
