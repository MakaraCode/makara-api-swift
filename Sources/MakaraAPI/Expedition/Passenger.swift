//
//  Passenger.swift
//  
//
//  Created by Hugh Jeremy on 21/8/20.
//

import Foundation


public struct Passenger: Codable, Listable, Identifiable, Hashable {
    
    public static let path = Expedition.path + "/passenger"
    
    public let expeditionId: String
    public let human: Human
    public let activities: Array<Activity>
    public let disposition: Disposition?
    public let orderBy: Self.OrderBy
    
    public var id: String { get { return self.expeditionId + human.publicId } }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        if (lhs.id == rhs.id) { return true }
        return false
    }
    
    internal enum CodingKeys: String, CodingKey {
        case expeditionId = "expedition_id"
        case human
        case activities
        case disposition
        case orderBy = "order_by"
    }
    
    public enum OrderBy: String, Codable {
        case name = "name"
    }
    
    public static func retrieve(
        session: Session,
        expedition: Expedition,
        human: Human,
        then callback: @escaping (Error?, Passenger?) -> Void
    ) {
        
        let targets = [
            UrlTarget(expedition, key: "expedition_id"),
            UrlTarget(human, key: "human_id")
        ]
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString(targetsOnly: targets),
            method: .GET
        ) { (e, d) in
            Request.decodeResponse(e, d, Self.self, callback)
            return
        }
        
        return

    }
    
    public static func retrieveMany(
        session: Session,
        human: Human? = nil,
        expedition: Expedition? = nil,
        limit: Int = 20,
        offset: Int = 0,
        order: Order = .ascending,
        orderBy: OrderBy = .name,
        then callback: @escaping (Error?, Array<Passenger>?) -> Void
    ) {
        
        let targets = [
            UrlTarget(limit, key: "limit"),
            UrlTarget(offset, key: "offset"),
            UrlTarget(order.rawValue, key: "order"),
            UrlTarget(orderBy.rawValue, key: "order_by"),
            human != nil ? UrlTarget(human!, key: "human_id") : nil,
            expedition != nil ? UrlTarget(
                expedition!,
                key: "expedition_id"
            ) : nil,
        ].compactMap { $0 }
        
        Self.retrieveMany(targets: targets, session: session, then: callback)
        
        return

    }

}
