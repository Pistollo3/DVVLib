//
//  AuthRequest.swift
//  VFGMVA10Foundation
//
//  Created by Esraa Eldaltony on 10/24/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
public enum AuthRequest: VFGRequestProtocol {
    public static var base = "https://eu2-stagingref.api.vodafone.com"
    public static var path = "/v1/apixoauth2password/oauth2/token"

    case getToken(authObject: Authentication)
    case refreshToken(authObject: Authentication, refreshToken: String)
    case getSoftLoginToken(authObject: Authentication)
    case getProductAndServicesToken(authObject: Authentication)
    case getSohoToken(authObject: Authentication)

    public var path: String {
        return AuthRequest.path
    }

    public var httpMethod: HTTPMethod {
        return .post
    }

    public var httpTask: HTTPTask {
        var params: VFGParameters?
        var headers: VFGHTTPHeaders?
        var encodingType: VFGParameterEncoder = .jsonEncoding

        switch self {
        case .getToken(authObject: let object):
            params = [
                (RequestParameterKey.clientIDKey, object.clientID ?? VFGDxlConstants.shared.clientID),
                (RequestParameterKey.grantTypeKey, object.grantType ?? ""),
                (RequestParameterKey.usernameKey, object.username ?? ""),
                (RequestParameterKey.passwordKey, object.password ?? ""),
                (RequestParameterKey.scopeKey, object.scope ?? "")
            ]
            headers = [
                RequestHeaderKey.contentTypeKey: object.contentType ?? "application/x-www-form-urlencoded",
                RequestHeaderKey.countryCodeKey: object.countryCode ?? VFGDxlConstants.shared.countryCode,
                RequestHeaderKey.vftargetStub: object.vfTargetStub ?? "true"
            ]

        case let .refreshToken(authObject: object, refreshToken: refreshToken):
            headers = [RequestHeaderKey.vftargetStub: object.vfTargetStub ?? "true"]

            params = [
                (RequestParameterKey.grantTypeKey, "refresh_token"),
                (RequestParameterKey.clientIDKey, object.clientID ?? VFGDxlConstants.shared.clientID),
                (RequestParameterKey.scopeKey, object.scope ?? ""),
                (RequestParameterKey.refreshTokenKey, refreshToken)
            ]

        case .getSoftLoginToken(authObject: let object) :
            params = [
                (RequestParameterKey.clientIDKey, object.clientID ?? VFGDxlConstants.shared.clientID),
                (RequestParameterKey.grantTypeKey, object.grantType ?? ""),
                (RequestParameterKey.codeKey, object.code ?? "")
            ]
            headers = [
                RequestHeaderKey.acceptKey: object.accept ?? "application/json",
                RequestHeaderKey.contentTypeKey: object.contentType ?? "application/x-www-form-urlencoded",
                RequestHeaderKey.acceptLanguageKey: object.acceptLanguage ?? "GR",
                RequestHeaderKey.vfEXTBPIDKey: object.vFEXTBPID ?? "TC01",
                RequestHeaderKey.vftargetStub: object.vfTargetStub ?? "true"
            ]

        case .getProductAndServicesToken(authObject: let object):
            AuthRequest.base = "https://eu2-stagingref.api.vodafone.com/"
            AuthRequest.path = "OAuth2PasswordGrant/v1/token"
            params = [
                (RequestParameterKey.grantTypeKey, object.grantType ?? ""),
                (RequestParameterKey.usernameKey, object.username ?? ""),
                (RequestParameterKey.passwordKey, object.password ?? ""),
                (RequestParameterKey.scopeKey, object.scope ?? "")
            ]
            headers = [
                RequestHeaderKey.authorizationKey: object.authorization ?? "",
                RequestHeaderKey.contentTypeKey: object.contentType ?? "application/x-www-form-urlencoded",
                RequestHeaderKey.countryCodeKey: object.countryCode ?? VFGDxlConstants.shared.countryCode
            ]
            encodingType = .bodyUrlEncoding

        case .getSohoToken(authObject: let object):
            AuthRequest.base = "https://eu2-stagingref.api.vodafone.com/"
            AuthRequest.path = "OAuth2TrustedLoginGrant/v1/token"
            params = [
                (RequestParameterKey.grantTypeKey, object.grantType ?? ""),
                (RequestParameterKey.loginHint, object.username ?? "")
            ]
            headers = [
                RequestHeaderKey.contentTypeKey: object.contentType ?? "application/x-www-form-urlencoded",
                RequestHeaderKey.countryCodeKey: object.countryCode ?? "EU",
                RequestHeaderKey.vfProject: object.vfProject ?? "SoHo",
                RequestHeaderKey.vfTargetEnvironment: object.vfTargetEnvironment ?? "dev",
                RequestHeaderKey.authorizationKey: object.authorization ?? ""
            ]
            encodingType = .bodyUrlEncoding
        }

        return .requestWithParametersAndHeaders(
            bodyParameters: params,
            bodyEncoding: encodingType,
            urlParameters: nil,
            extraHeaders: headers)
    }

    public var headers: VFGHTTPHeaders? {
        return [:]
    }

    public var isAuthenticationNeededRequest: Bool? {
        return false
    }

    public var cachePolicy: VFGCachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}

public enum VFGAuthenticationError: String, Error {
    case authenticationObjectNil = "Authentication Object is nil"
    case authenticationObjectOrTokenNil = "Authentication Object is nil or there's not saved token"
}
