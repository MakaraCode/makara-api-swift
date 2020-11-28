//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 28/11/20.
//

import Foundation


internal protocol Listable: Codable {
    
    static var listPath: String { get }
    
}

extension Listable {
    
    internal static func retrieveMany(
        targets: Array<UrlTarget>,
        session: Session?,
        then callback: @escaping (_: Error?, _: Array<Self>?) -> Void
    ) {
        
        Request.make(
            path: Self.listPath,
            data: nil,
            session: session,
            query: QueryString(targetsOnly: targets),
            method: HTTPMethod.GET,
            then: { (error, data) in
                Request.decodeResponse(error, data, Array<Self>.self, callback)
                return
            }
        )
        
    }
    
}
