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
    
    private enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case publicId = "public_id"
        case userPublicId = "agent_id"
    }
    
    static func create(
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
    
    static func create(
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

}
