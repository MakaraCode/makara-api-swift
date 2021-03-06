//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 28/11/20.
//

import Foundation


public struct Expedition: PubliclyRetrievable, Journaled, Listable {
    
    public static let path = "/expedition"
    
    public let journalEntry: JournalEntry
    public let checkinTime: Date
    public let checkinLocation: PointOfInterest
    public let departureTime: Date
    public let vehicle: Vehicle?
    public let crew: Array<CrewMember>
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
        case crew
        case shopId = "shop_id"
        case orderBy = "order_by"
        case disposition
    }
    
    public func update(
        session: Session,
        checkinTime: Date,
        checkinLocation: PointOfInterest,
        departureTime: Date,
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
    
    public func update(
        session: Session,
        checkinTime: Date? = nil,
        checkinLocation: PointOfInterest? = nil,
        departureTime: Date? = nil,
        vehicle: Vehicle? = nil,
        then callback: @escaping (Error?, Expedition?) -> Void
    ) {
        
        Self.create(
            publicId: self.publicId,
            checkinTime: checkinTime ?? self.checkinTime,
            checkinLocation: checkinLocation ?? self.checkinLocation,
            departureTime: departureTime ?? self.departureTime,
            shopId: self.shopId,
            session: session,
            vehicle: vehicle ?? self.vehicle,
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
        maxDepartureTime: Date? = nil,
        minDepartureTime: Date? = nil,
        byShop shop: Shop? = nil,
        publicId: String? = nil,
        then callback: @escaping (Error?, Array<Expedition>?) -> Void
    ) {
        
        let targets = [
            UrlTarget(offset, key: "offset"),
            UrlTarget(limit, key: "limit"),
            UrlTarget(order.rawValue, key: "order"),
            UrlTarget(orderBy.rawValue, key: "order_by"),
            publicId != nil ? UrlTarget(publicId!, key: "public_id") : nil,
            shop != nil ? UrlTarget(shop!.publicId, key: "shop_id") : nil,
            maxDepartureTime != nil ? UrlTarget(
                maxDepartureTime!,
                key: "max_depart_time"
            ) : nil,
            minDepartureTime != nil ? UrlTarget(
                minDepartureTime!,
                key: "min_depart_time"
            ) : nil
        ].compactMap { $0 }
                      
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
