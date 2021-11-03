//
//  VFGProductsDXLConstants.swift
//  VFGMVA10Foundation
//
//  Created by Moustafa Hegazy on 16/03/2021.
//

import Foundation

public class VFGProductsDXLConstants {
    public static let shared = VFGProductsDXLConstants()
    private init() {}

    public var baseUrl = "https://eu2-stagingref.api.vodafone.com"
    public var authenticationPathUrl = "/OAuth2PasswordGrant/v1/token"
    public var clientID = "0KlAsrVaURa3DGnqrVWBI9jLlZ7HQJAv"
    public var countryCode = "EU"
    public var grantType = "password"
    public var accept = "application/json"
    public var acceptLanguage = "en"
    public var contentType = "application/x-www-form-urlencoded"
    public var scope = "PRODUCTS_AND_SERVICES_ALL DIGITAL_PRODUCT_RECOMMENDATION_ALL"
    public var authorizationToken = "Basic MEtsQXNyVmFVUmEzREducXJWV0JJOWpMbFo3SFFKQXY6QW4zNWdrYmNkZWcwTUd1TQ=="
}
