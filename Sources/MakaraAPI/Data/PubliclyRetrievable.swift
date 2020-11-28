//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 28/11/20.
//

import Foundation


public protocol PubliclyRetrievable: PubliclyIdentified, Codable {
    
    static var path: String { get }
    
}

extension PubliclyRetrievable {
    
    public static func retrieve(
        withPublicId publicId: String,
        session: Session,
        then callback: @escaping (Error?, Self?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [
                    UrlTarget(stringValue: publicId, key: "public_id")
                ]
            ),
            method: HTTPMethod.GET,
            then: { (error, data) in
                Request.decodeResponse(error, data, Self.self, callback)
                return
            }
        )
        
    }
    
}
