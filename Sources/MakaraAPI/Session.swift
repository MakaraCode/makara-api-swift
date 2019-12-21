//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation
import CryptoKit


class Session: Decodable {
    
    private static let path = "/session"
    
    public let publicId: String
    public let apiKey: String
    public let userPublicId: String
    
    required init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: Keys.self)
        publicId = try data.decode(String.self, forKey: .sessionId)
        apiKey = try data.decode(String.self, forKey: .apiKey)
        userPublicId = try data.decode(String.self, forKey: .userId)
        return
    }
    
    private enum Keys: String, CodingKey {
        case apiKey = "api_key"
        case sessionId = "session_id"
        case userId = "user_id"
    }

    internal func signature(
        path: String,
        data: RequestData?,
        apiKey: Data
    ) throws -> String {

        let payload = data?.encodedDataString ?? ""
        let timestamp = String(describing: Int(Date().timeIntervalSince1970))
        let stringToHash = timestamp + path + payload
        let hmac = HMAC<SHA512>.authenticationCode(
            for: stringToHash.data(using: .utf8)!,
            using: SymmetricKey(data: apiKey)
        )

        return String(describing: hmac)
    }
    
}
