//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 31/1/21.
//

import Foundation


public struct GenericLocation: PubliclyRetrievable, Located, Journaled {
    
    static public let path = PointOfInterest.path + "/generic"
    
    public let journalEntry: JournalEntry
    public let pointOfInterest: PointOfInterest
    public let shopId: String
    
    enum CodingKeys: String, CodingKey {
        case journalEntry = "journal"
        case pointOfInterest = "point_of_interest"
        case shopId = "shop_id"
    }
    
    public static func create(
        session: Session,
        shop: Shop,
        name: String,
        location: Location,
        then callback: @escaping (Error?, GenericLocation?) -> Void
    ) {
        
        let payload = CreatePayload(
            shop_id: shop.publicId,
            name: name,
            location: location
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: .POST
        ) { (e, d) in
            Request.decodeResponse(e, d, Self.self, callback)
            return
        }
        
        return

    }
    
    public func update(
        session: Session,
        active: Bool,
        then callback: @escaping (Error?, GenericLocation?) -> Void
    ) {
        
        let payload = Self.UpdatePayload(
            generic_id: self.pointOfInterest.publicId,
            active: active
        )

        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: .PUT
        ) { (e, d) in
            Request.decodeResponse(e, d, Self.self, callback)
            return
        }

        return

    }

    private struct UpdatePayload: Encodable {
        let generic_id: String
        let active: Bool
    }

    private struct CreatePayload: Encodable {
        let shop_id: String
        let name: String
        let location: Location
    }

}
