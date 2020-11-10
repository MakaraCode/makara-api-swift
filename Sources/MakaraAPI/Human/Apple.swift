//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 5/11/20.
//

import Foundation


public struct AppleHuman: Codable, PubliclyIdentified {
    
    private static let path = Human.path + "/apple"
    
    public let human: Human
    public let appleId: String
    public var publicId: String { get { return self.human.publicId } }

    private enum CodingKeys: String, CodingKey {
        case human
        case appleId = "apple_id"
    }
    
    public static func create(
        identityToken: String,
        name: HumanName,
        session: Session?,
        then callback: @escaping (Error?, AppleHuman?) -> Void
    ) {
     
        Request.make(
            path: Self.path,
            payload: Self.CreatePayload(
                name: name,
                identity_token: identityToken
            ),
            session: session,
            query: nil,
            method: HTTPMethod.POST,
            then: { (error: Error?, data: Data?) -> Void in
                Request.decodeResponse(error, data, Self.self, callback)
                return
            }
        )

        return

    }
    
    public static func retrieve(
        identityToken: String,
        session: Session?,
        then callback: @escaping (Error?, AppleHuman?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString(targetsOnly: [
                UrlTarget(stringValue: identityToken, key: "token")
            ]),
            method: HTTPMethod.GET,
            then: { (error: Error?, data: Data?) -> Void in
                Request.decodeResponse(error, data, Self.self, callback)
                return
            }
        )
        
    }
    
    fileprivate struct CreatePayload: Codable {
        let name: HumanName
        let identity_token: String
    }

}
