//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 28/12/20.
//

import Foundation


public struct Participant: Codable, Listable {
 
    public static let path = Expedition.path + "/participant"
    
    public let legId: String
    public let human: Human
    public let activities: Array<Activity>
    public let active: Bool
    public let disposition: Disposition?
    
    internal enum CodingKeys: String, CodingKey {
        case legId = "leg_id"
        case human
        case activities
        case active
        case disposition
    }
    
    public func update(
        session: Session,
        activities: Array<Activity>,
        active: Bool = true,
        then callback: @escaping (Error?, Participant?) -> Void
    ) {
        
        let payload = UpdatePayload(
            active: active,
            activities: activities,
            human_id: self.human.publicId,
            leg_id: self.legId
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: .PUT,
            then: { (e, d) in
                Request.decodeResponse(e, d, Self.self, callback)
            }
        )
        
        return

    }
    
    public static func create(
        session: Session,
        leg: Leg,
        human: Human,
        activities: Array<Activity>,
        then callback: @escaping (Error?, Participant?) -> Void
    ) {
        
        let payload = Self.CreatePayload(
            activities: activities,
            human_id: human.publicId,
            leg_id: leg.publicId
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: .POST,
            then: { (e, d) in
                Request.decodeResponse(e, d, Self.self, callback)
            }
        )
        
        return
        
    }
    
    public static func retrieve(
        session: Session,
        leg: Leg,
        human: Human,
        then callback: @escaping (Error?, Self?) -> Void
    ) {
        
        let targets = [
            UrlTarget(leg, key: "leg_id"),
            UrlTarget(human, key: "human_id")
        ]
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString(targetsOnly: targets),
            method: .GET,
            then: { (e, d) in
                Request.decodeResponse(e, d, Self.self, callback, true)
            }
        )
        
        return

    }
    
    public static func retrieveMany(
        session: Session,
        order: Order = .ascending,
        orderBy: Self.OrderBy = .name,
        offset: Int = 0,
        limit: Int = 20,
        expedition: Expedition? = nil,
        leg: Leg? = nil,
        human: Human? = nil,
        active: Bool? = nil,
        then callback: @escaping (Error?, Array<Self>?) -> Void
    ) {
        
        let targets = [
            UrlTarget(offset, key: "offset"),
            UrlTarget(limit, key: "limit"),
            UrlTarget(order.rawValue, key: "order"),
            UrlTarget(orderBy.rawValue, key: "order_by"),
            expedition != nil ? UrlTarget(
                expedition!,
                key: "expedition_id"
            ) : nil,
            leg != nil ? UrlTarget(leg!, key: "leg_id"): nil,
            human != nil ? UrlTarget(human!, key: "human_id") : nil,
            active != nil ? UrlTarget(active!, key: "active") : nil
        ].compactMap { $0 }
        
        Self.retrieveMany(
            targets: targets,
            session: session,
            then: callback
        )
        
        return

    }
    
    public enum OrderBy: String, Codable {
        case modified = "modified"
        case created = "created"
        case name = "name"
    }
    
    private struct CreatePayload: Encodable {
        let activities: Array<Activity>
        let human_id: String
        let leg_id: String
    }
    
    private struct UpdatePayload: Encodable {
        let active: Bool
        let activities: Array<Activity>
        let human_id: String
        let leg_id: String
    }
    
}
