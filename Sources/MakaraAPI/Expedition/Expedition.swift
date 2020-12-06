//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 28/11/20.
//

import Foundation


public struct Expedition: PubliclyRetrievable, Journaled, Listable {
    
    public static let path = "/expedition"
    internal static let listPath = Self.path + "/list"
    
    public let journalEntry: JournalEntry
    public let checkinTime: Date
    public let checkinLocation: PointOfInterest
    public let departureTime: Date
    public let vehicle: Vehicle?
    public let shopId: String
    public let orderBy: Expedition.OrderBy
    public let disposition: Disposition
    
    public enum OrderBy: String, Codable {
        case departureTime = "departure_time"
    }
    
    internal enum CodingKeys: String, CodingKey {
        case journalEntry = "journal"
        case checkinTime = "checkin_time"
        case checkinLocation = "checkin_location"
        case departureTime = "departure_time"
        case vehicle
        case shopId = "shop_id"
        case orderBy = "order_by"
        case disposition
    }
    
    public func update(
        checkinTime: Date,
        checkinLocation: PointOfInterest,
        departureTime: Date,
        session: Session,
        vehicle: Vehicle? = nil,
        then callback: @escaping (_: Error?, _: Expedition?) -> Void
    ) {

        Self.create(
            publicId: self.publicId,
            checkinTime: checkinTime,
            checkinLocation: checkinLocation,
            departureTime: departureTime,
            shopId: self.shopId,
            session: session,
            vehicle: vehicle,
            method: .PUT,
            then: callback
        )
        
        return
        
    }
    
    public static func create(
        checkinTime: Date,
        checkinLocation: Located,
        departureTime: Date,
        shop: Shop,
        session: Session,
        vehicle: Vehicle? = nil,
        then callback: @escaping (_: Error?, _: Expedition?) -> Void
    ) {
        
        Self.create(
            publicId: nil,
            checkinTime: checkinTime,
            checkinLocation: checkinLocation.pointOfInterest,
            departureTime: departureTime,
            shopId: shop.publicId,
            session: session,
            vehicle: vehicle,
            method: .POST,
            then: callback
        )
        
        return
    }
    
    private static func create(
        publicId: String? = nil,
        checkinTime: Date,
        checkinLocation: PointOfInterest,
        departureTime: Date,
        shopId: String,
        session: Session,
        vehicle: Vehicle? = nil,
        method: HTTPMethod,
        then callback: @escaping (_: Error?, _: Expedition?) -> Void
    ) {
        
        let payload = Expedition.Payload(
            shop_id: shopId,
            checkin_time: checkinTime,
            checkin_location: checkinLocation.publicId,
            departure_time: departureTime,
            vehicle: vehicle?.publicId,
            public_id: publicId
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: method,
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
        orderBy: Expedition.OrderBy = .departureTime,
        offset: Int = 0,
        limit: Int = 20,
        byShop shop: Shop? = nil,
        publicId: String? = nil,
        then callback: @escaping (_: Error?, _: Array<Expedition>?) -> Void
    ) {
        
        var targets = [
            UrlTarget(offset, key: "offset"),
            UrlTarget(limit, key: "limit"),
            UrlTarget(order.rawValue, key: "order"),
            UrlTarget(orderBy.rawValue, key: "order_by")
        ]
                      
        if let publicId = publicId {
            targets.append(UrlTarget(publicId, key: "public_id"))
        }
        
        if let shop = shop {
            targets.append(UrlTarget(shop.publicId, key: "shop_id"))
        }
        
        Self.retrieveMany(
            targets: targets,
            session: session,
            then: callback
        )

        return
        
    }
    
    internal struct Payload: Codable {
        let shop_id: String
        let checkin_time: Date
        let checkin_location: String
        let departure_time: Date
        let vehicle: String?
        let public_id: String?
    }
    
}
