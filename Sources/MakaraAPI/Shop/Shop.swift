//
//  Shop.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


public struct Shop: Codable, Journaled, Located, PubliclyRetrievable {
    
    public static let path = "/shop"
    internal static let listPath = Self.path + "/list"
    
    public let journalEntry: JournalEntry
    public let pointOfInterest: PointOfInterest
    public let address: Address?
    public let disposition: Disposition
    public let orderBy: Shop.OrderBy
    
    enum CodingKeys: String, CodingKey {
        case journalEntry = "journal"
        case pointOfInterest = "point_of_interest"
        case address
        case disposition
        case orderBy = "order_by"
    }
    
    public func update(
        session: Session,
        name: String,
        then callback: @escaping (Error?, Shop?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            payload: UpdatePayload(public_id: self.publicId, name: name),
            session: session,
            query: nil,
            method: HTTPMethod.PUT,
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
        orderBy: Shop.OrderBy = .name,
        offset: Int = 0,
        limit: Int = 20,
        then callback: @escaping (_: Error?, _: Array<Shop>?) -> Void
    ) {
        
        let targets = [
            UrlTarget(integerValue: offset, key: "offset"),
            UrlTarget(integerValue: limit, key: "limit"),
            UrlTarget(stringValue: order.rawValue, key: "order"),
            UrlTarget(stringValue: orderBy.rawValue, key: "order_by")
        ]
        
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

        return
        
    }
    
    public static func create(
        name: String,
        session: Session,
        location: Location,
        then callback: @escaping (_: Error?, _: Shop?) -> Void
    ) {
        
        let payload = CreatePayload(
            name: name,
            location: location
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: HTTPMethod.POST,
            then: { (error, data) in
                Request.decodeResponse(error, data, Self.self, callback)
                return
            }
        )
        
        return

    }
    
    fileprivate struct CreatePayload: Codable {
        let name: String
        let location: Location
    }
    
    fileprivate struct UpdatePayload: Codable {
        let public_id: String
        let name: String
    }

    public enum OrderBy: String, Codable {
        case name = "name"
        case created = "created"
        case metresFromReference = "metres_from_reference"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(publicId)
    }
    
    public static func == (lhs: Shop, rhs: Shop) -> Bool {
        if (lhs.publicId == rhs.publicId) { return true }
        return false
    }

}
