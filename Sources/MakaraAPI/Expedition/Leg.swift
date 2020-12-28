//
//  Leg.swift
//  
//
//  Created by Hugh Jeremy on 23/12/20.
//

import Foundation


public struct Leg: PubliclyRetrievable, Journaled, Listable {
 
    public static var path: String { get { return Expedition.path + "/leg" } }
    
    public let expeditionId: String
    public let active: Bool
    public let disposition: Disposition?
    public let journalEntry: JournalEntry
    
    public enum OrderBy: String, Codable {
        case sequence = "sequence"
    }
    
    internal enum CodingKeys: String, CodingKey {
        case expeditionId = "expedition_id"
        case active
        case disposition
        case journalEntry = "journal"
    }
    
    public func update(
        session: Session,
        location: PointOfInterest? = nil,
        sequence: Int,
        active: Bool,
        then callback: @escaping (_: Error?, _: Leg?) -> Void
    ) {
        
        let payload = Self.UpdatePayload(
            public_id: self.publicId,
            sequence: sequence,
            active: active,
            location_id: location?.publicId
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: .PUT,
            then: { (error, data) in
                Request.decodeResponse(error, data, Self.self, callback)
                return
            }
        )
        
        return
        
    }
    
    public static func retrieveMany(
        session: Session,
        order: Order = .ascending,
        orderBy: Leg.OrderBy = .sequence,
        offset: Int = 0,
        limit: Int = 20,
        expedition: Expedition? = nil,
        publicId: String? = nil,
        active: Bool? = nil,
        then callback: @escaping (_: Error?, _: Array<Leg>?) -> Void
    ) {
        
        let targets = [
            UrlTarget(offset, key: "offset"),
            UrlTarget(limit, key: "limit"),
            UrlTarget(order.rawValue, key: "order"),
            UrlTarget(orderBy.rawValue, key: "order_by"),
            publicId != nil ? UrlTarget(publicId!, key: "public_id") : nil,
            expedition != nil ? UrlTarget(
                expedition!.publicId,
                key: "expedition_id"
            ) : nil,
            active != nil ? UrlTarget(active!, key: "active") : nil
        ].compactMap { $0 }

        Self.retrieveMany(targets: targets, session: session, then: callback)
        
        return

    }
    
    public static func create(
        session: Session,
        expedition: Expedition,
        sequence: Int,
        location: PointOfInterest? = nil,
        then callback: @escaping (_: Error?, _: Leg?) -> Void
    ) {
        
        let payload = Self.CreatePayload(
            expedition_id: expedition.publicId,
            public_id: nil,
            sequence: sequence,
            location_id: location?.publicId
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: .POST,
            then: { (error, data) in
                Request.decodeResponse(error, data, Self.self, callback)
                return
            }
        )
        
        return

    }
    
    private struct CreatePayload: Encodable {
        let expedition_id: String
        let public_id: String?
        let sequence: Int
        let location_id: String?
    }
    
    private struct UpdatePayload: Encodable {
        let public_id: String
        let sequence: Int
        let active: Bool
        let location_id: String?
    }

}
