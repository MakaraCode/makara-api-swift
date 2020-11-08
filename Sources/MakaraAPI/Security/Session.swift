//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation
import CryptoKit


public struct Session: Codable {
    
    private static let path = "/session"
    
    public let publicId: String
    public let apiKey: String
    public let userPublicId: String
    
    public init (
        publicId: String,
        apiKey: String,
        userPublicId: String
    ) {
        self.publicId = publicId
        self.apiKey = apiKey
        self.userPublicId = userPublicId
        return
    }
    
    private enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case publicId = "public_id"
        case userPublicId = "agent_id"
    }
    
    public static func create(
        email: String,
        secret: String,
        then callback: @escaping (Error?, Session?) -> Void
    ) -> Void {
        
        Request.make(
            path: Self.path,
            payload: Self.SecretPayload(
                secret: secret,
                email: email
            ),
            session: nil,
            query: nil,
            method: HTTPMethod.POST,
            then: { (error: Error?, data: Data?) -> Void in
                Request.decodeResponse(error, data, Self.self, callback)
            }
        )
        
        return
        
    }
    
    public static func create(
        token: String,
        then callback: @escaping (Error?, Session?) -> Void
    ) -> Void {
        
        Request.make(
            path: Self.path,
            payload: Self.TokenPayload(token: token),
            session: nil,
            query: nil,
            method: HTTPMethod.POST,
            then: { (error: Error?, data: Data?) -> Void in
                Request.decodeResponse(error, data, Self.self, callback)
            }
        )
        
        return

    }
    
    public static func create(
        siwaToken: String,
        then callback: @escaping (Error?, Session?) -> Void
    ) -> Void {
        
        Request.make(
            path: Self.path,
            payload: Self.SiwaPayload(siwa_token: siwaToken),
            session: nil,
            query: nil,
            method: HTTPMethod.POST,
            then: { (error: Error?, data: Data?) -> Void in
                Request.decodeResponse(error, data, Self.self, callback)
            }
        )
        
        return

    }

    public static func fromEnvironmentVariables(
        publicIdVariableName: String = "MAKARA_API_SESSION_ID",
        apiKeyVariableName: String = "MAKARA_API_KEY",
        userIdVariableName: String = "MAKARA_API_USER_ID"
    ) throws -> Session {
        
        guard let ePublicId = getenv(publicIdVariableName) else {
            throw MakaraAPIError(.badConfiguration)
        }
        
        guard let publicId = String(utf8String: ePublicId) else {
            throw MakaraAPIError(.badConfiguration)
        }
        
        guard let eApiKey = getenv(apiKeyVariableName) else {
            throw MakaraAPIError(.badConfiguration)
        }
        
        guard let apiKey = String(utf8String: eApiKey) else {
            throw MakaraAPIError(.badConfiguration)
        }
        
        guard let eUserId = getenv(userIdVariableName) else {
            throw MakaraAPIError(.badConfiguration)
        }
        
        guard let userId = String(utf8String: eUserId) else {
            throw MakaraAPIError(.badConfiguration)
        }

        return MakaraAPI.Session(
            publicId: publicId,
            apiKey: apiKey,
            userPublicId: userId
        )

    }

    internal func signature(
        path: String,
        data: RequestData?,
        apiKey: Data
    ) throws -> String {

        let payload = data?.encodedDataString ?? ""
        let timestamp = String(describing: Int(Date().timeIntervalSince1970))
        let stringToHash = timestamp + path + payload
        let hmac = HMAC<SHA256>.authenticationCode(
            for: stringToHash.data(using: .utf8)!,
            using: SymmetricKey(data: apiKey)
        )

        return String(describing: hmac)
    }
    
    fileprivate struct SecretPayload: Codable {
        let secret: String
        let email: String
    }
    
    fileprivate struct TokenPayload: Codable {
        let token: String
    }
    
    fileprivate struct SiwaPayload: Codable {
        let siwa_token: String
    }

}
