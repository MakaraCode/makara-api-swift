//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 31/7/20.
//

import Foundation


public struct DiveSite: Journaled, Located, Listable, PubliclyRetrievable {
    
    public static let path = "/dive-site"
    
    public let journalEntry: JournalEntry
    public let pointOfInterest: PointOfInterest
    public let description: String?
    public let tags: Array<Tag>
    public let disposition: Disposition?
    public let orderBy: DiveSite.OrderBy
    
    public enum OrderBy: String, Codable {
        case name = "name"
        case metresFromReference = "metres_from_reference"
        case created = "created"
    }

    internal enum CodingKeys: String, CodingKey {
        case journalEntry = "journal"
        case pointOfInterest = "point_of_interest"
        case description
        case tags
        case disposition
        case orderBy = "order_by"
    }

    public func update(
        session: Session,
        name: String? = nil,
        description: String? = nil,
        location: Location? = nil,
        then callback: @escaping (Error?, DiveSite?) -> Void
    ) {
        
        let payload = DiveSite.UpdatePayload(
            description: description ?? self.description,
            name: name ?? self.name,
            public_id: self.publicId,
            location: self.pointOfInterest.location
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: HTTPMethod.PUT,
            then: { e, d in Request.decodeResponse(e, d, Self.self, callback) }
        )
        
        return

    }
    
    public static func create(
        session: Session,
        name: String,
        description: String?,
        location: Location,
        publicId: String? = nil,
        then callback: @escaping (Error?, DiveSite?) -> Void
    ) {
        
        let payload = DiveSite.CreatePayload(
            public_id: publicId,
            name: name,
            location: location,
            description: description
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: HTTPMethod.POST,
            then: { e, d in Request.decodeResponse(e, d, Self.self, callback) }
        )
        
        return
        
    }
    
    public static func retrieveMany(
        session: Session,
        order: Order = .ascending,
        orderBy: DiveSite.OrderBy = .name,
        offset: Int = 0,
        limit: Int = 20,
        offeredBy: Shop? = nil,
        withReferenceTo loc: Location? = nil,
        nameFragment: String? = nil,
        then callback: @escaping (Error?, Array<DiveSite>?) -> Void
    ) {
        
        let targets = [
            UrlTarget(offset, key: "offset"),
            UrlTarget(limit, key: "limit"),
            UrlTarget(order),
            UrlTarget(orderBy.rawValue, key: "order_by"),
            offeredBy != nil ? UrlTarget(offeredBy!, key: "offered_by") : nil,
            loc != nil ? UrlTarget(loc!, key: "with_reference_to") : nil,
            nameFragment != nil ? UrlTarget(
                nameFragment!,
                key: "name_fragment"
            ) : nil
        ].compactMap { $0 }
        
        self.retrieveMany(
            targets: targets,
            session: session,
            then: callback
        )
        
        return

    }
    
    private struct CreatePayload: Encodable {
        let public_id: String?
        let name: String
        let location: Location
        let description: String?
    }
    
    private struct UpdatePayload: Encodable {
        let description: String?
        let name: String
        let public_id: String
        let location: Location
    }

}
