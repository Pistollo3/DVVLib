//
//  VFGLoginProvider.swift
//  VFGLogin
//
//  Created by Atta Ahmed on 12/15/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation

/**
API configuration for Login.
- getPinCodeRequest: get the request for pin code.
- createParametersForGetPinCode: create url parameters for pin code request.
- requestSoftLoginAuthentication: Request the authentication for pin code.
- createPinCodeRequest: Creates the full url request for pin code.
*/
public protocol VFGLoginProviderProtocol {
    func getPinCodeRequest<T: Codable>(
        model: T.Type,
        completion: @escaping (T?, Error?) -> Void
    )
    func createParametersForGetPinCode(phoneNumber: String) -> VFGParameters
    func requestSoftLoginAuthentication(code: String, path: String, completion: @escaping Success)
    func createPinCodeRequest(bodyParameters: VFGParameters, path: String) -> VFGRequest?
}

/// Default implementation of VFGLoginProviderProtocol
public class VFGLoginProvider: VFGLoginProviderProtocol {
    private var loginRequest: VFGRequest?
    private var networkClient: VFGNetworkClient?
    private var isAPIRequestEnabled = true

    public init(
        baseURL: String = "https://eu2-stagingref.api.vodafone.com/",
        loginRequest: VFGRequest? = nil,
        isAPIRequestEnabled: Bool? = true
    ) {
        self.loginRequest = loginRequest
        self.isAPIRequestEnabled = isAPIRequestEnabled ?? true
        networkClient = VFGNetworkClient(baseURL: baseURL)
    }
    public func setNetworkClient(client: VFGNetworkClient) {
        networkClient = client
    }

    public func createParametersForGetPinCode(phoneNumber: String) -> VFGParameters {
        return [
            ("response_type", "code"),
            ("client_id", VFGDxlConstants.shared.clientID),
            ("login_hint", phoneNumber)
        ]
    }

    public func createPinCodeRequest(bodyParameters: VFGParameters, path: String) -> VFGRequest? {
        let headers = [
            "Accept": VFGDxlConstants.shared.accept,
            "Content-Type": VFGDxlConstants.shared.contentType,
            "Accept-Language": VFGDxlConstants.shared.acceptLanguage,
            "VF_EXT_BP_ID": "TC01",
            "vf-target-stub": "true"
        ]
        let requestParameters: HTTPTask = .requestWithParameters(
            bodyParameters: bodyParameters,
            bodyEncoding: .jsonEncoding,
            urlParameters: nil)

        return VFGRequest(
            path: path,
            httpMethod: .post,
            httpTask: requestParameters,
            headers: headers,
            isAuthenticationNeededRequest: true,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
    }

    public func convertPinTobase64(pin: String, phone: String) -> String {
        let code = "\(phone):\(pin)"
        return code.toBase64()
    }

    public func getPinCodeRequest<T: Codable>(model: T.Type, completion: @escaping (T?, Error?) -> Void) {
        guard let loginRequest = loginRequest else {
            return
        }

        guard isAPIRequestEnabled else {
            return completion(nil, nil)
        }

        networkClient?.executeData(
            request: loginRequest,
            model: model) { result in
            switch result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    public func requestSoftLoginAuthentication(code: String, path: String, completion: @escaping Success) {
        guard isAPIRequestEnabled else {
            return completion(nil, nil)
        }
        let obj = Authentication(
            authenticationBaseUrl: "https://eu2-stagingref.api.vodafone.com",
            authenticationPathUrl: path,
            grantType: VFGDxlConstants.shared.grantType,
            clientID: VFGDxlConstants.shared.clientID,
            accept: VFGDxlConstants.shared.accept,
            acceptLanguage: VFGDxlConstants.shared.acceptLanguage,
            vFEXTBPID: "TC01",
            countryCode: VFGDxlConstants.shared.countryCode,
            vfTargetStub: "true",
            contentType: VFGDxlConstants.shared.contentType,
            code: code)
        let authobj = OAuth2Authentication()
        if !authobj.isAuthenticated() {
            authobj.softLoginRequested(
            authenticationObject: obj) { error in
                completion(nil, error)
            }
        }
        authobj.requestSoftLoginAuthentication(closure: completion)
    }
}

public class LoginResponse: Codable {
    let message: String?
}
