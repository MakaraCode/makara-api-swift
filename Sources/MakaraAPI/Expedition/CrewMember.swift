//
//  File 2.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct CrewMember: PubliclyIdentified, Listable, Journaled {
    
    static let path = Expedition.path + "/crewmember"
    
    public let journalEntry: JournalEntry
    public let role: CrewMember.Role
    public let teammember: Teammember
    public let expeditionId: String
    public let orderBy: CrewMember.OrderBy
    public let active: Bool
    public let disposition: Disposition?

    private enum CodingKeys: String, CodingKey {
        case journalEntry = "journal"
        case role
        case teammember
        case expeditionId = "expedition_id"
        case orderBy = "order_by"
        case active
        case disposition
    }
    
    public enum OrderBy: String, Codable {
        case name = "name"
        case created = "created"
        case modified = "modified"
    }
    
    public enum Role: Int, Codable {
        case captain = 1
        case crew = 2
    }
    
    public func update(
        session: Session,
        active: Bool,
        role: CrewMember.Role,
        then callback: @escaping (Error?, CrewMember?) -> Void
    ) {
        
        let payload = UpdatePayload(
            public_id: self.publicId,
            role: role.rawValue,
            active: active
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: .PUT,
            then: { (e, d) in
                Request.decodeResponse(e, d, Self.self, callback, false)
                return
            }
        )
        
        return

    }
    
    public static func create(
        session: Session,
        teammember: Teammember,
        expedition: Expedition,
        role: CrewMember.Role,
        callback: @escaping (Error?, CrewMember?) -> Void
    ) {
        
        let payload = CreatePayload(
            expedition_id: expedition.publicId,
            role: role.rawValue,
            teammember_id: teammember.publicId
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: .POST,
            then: { e, d in
                Request.decodeResponse(e, d, Self.self, callback, false)
                return
            }
        )
        
        return
        
    }
    
    public static func retrieveMany(
        session: Session,
        order: Order = .ascending,
        orderBy: CrewMember.OrderBy = .name,
        offset: Int = 0,
        limit: Int = 20,
        shop: Shop? = nil,
        human: Human? = nil,
        expedition: Expedition? = nil,
        publicId: String? = nil,
        then callback: @escaping (_: Error?, _: Array<CrewMember>?) -> Void
    ) {
        
        let targets = [
            UrlTarget(offset, key: "offset"),
            UrlTarget(limit, key: "limit"),
            UrlTarget(order.rawValue, key: "order"),
            UrlTarget(orderBy.rawValue, key: "order_by"),
            shop != nil ? UrlTarget(shop!.publicId, key: "shop_id") : nil,
            human != nil ? UrlTarget(human!.publicId, key: "human_id") : nil,
            expedition != nil ? UrlTarget(
                expedition!.publicId,
                key: "expedition_id"
            ) : nil,
            publicId != nil ? UrlTarget(publicId!, key: "public_id") : nil
        ].compactMap { $0 }
        
        Self.retrieveMany(
            targets: targets,
            session: session,
            then: callback
        )
        
        return
    }
    
    private struct CreatePayload: Codable {
        let expedition_id: String
        let role: Int
        let teammember_id: String
    }
    
    private struct UpdatePayload: Codable {
        let public_id: String
        let role: Int
        let active: Bool
    }

}
