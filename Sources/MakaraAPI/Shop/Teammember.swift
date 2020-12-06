//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 6/12/20.
//

import Foundation


public struct Teammember: PubliclyRetrievable, Journaled, Listable {
    
    public static let path = Shop.path + "/teammember"
    internal static let listPath = Self.path + "/list"
    
    public let journalEntry: JournalEntry
    public let human: Human
    public let shopId: String
    public let active: Bool
    public let disposition: Disposition?
    
    internal enum CodingKeys: String, CodingKey {
        case journalEntry = "journal"
        case human
        case shopId = "shop_id"
        case active
        case disposition
    }
    
    private static func _create(
        shopId: String,
        humanId: String,
        active: Bool,
        session: Session,
        callback: @escaping (Error?, Teammember?) -> Void
    ) {
        
        let payload = CreatePayload(
            shop_id: shopId,
            human_id: humanId,
            active: active
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: .POST,
            then: { (e, d) in
                Request.decodeResponse(e, d, Self.self, callback, false)
                return
            }
        )
        
        return
        
    }
    
    public func update(
        active: Bool,
        session: Session,
        callback: @escaping (Error?, Teammember?) -> Void
    ) {
        
        let payload = UpdatePayload(public_id: self.publicId, active: active)
        
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
        
    }
    
    public static func create(
        shop: Shop,
        human: Human,
        session: Session,
        callback: @escaping (Error?, Teammember?) -> Void
    ) {
        
        Self._create(
            shopId: shop.publicId,
            humanId: human.publicId,
            active: true,
            session: session,
            callback: callback
        )
        
        return
        
    }
    
    public enum OrderBy: String, Codable {
        case modified = "modified"
        case created = "created"
        case name = "name"
    }
    
    public static func retrieveMany(
        session: Session,
        shop: Shop? = nil,
        human: Human? = nil,
        active: Bool? = nil,
        limit: Int = 20,
        offset: Int = 0,
        orderBy: OrderBy = OrderBy.name,
        order: Order = Order.ascending,
        callback: @escaping (Error?, Array<Teammember>?) -> Void
    ) {
        
        let targets = [
            shop != nil ? UrlTarget(shop!.publicId, key: "shop_id") : nil,
            human != nil ? UrlTarget(human!.publicId, key: "human_id") : nil,
            active != nil ? UrlTarget(active!, key: "active"): nil,
            UrlTarget(limit, key: "limit"),
            UrlTarget(offset, key: "offset"),
            UrlTarget(order.rawValue, key: "order"),
            UrlTarget(orderBy.rawValue, key: "order_by")
        ].compactMap { $0 }
        
        Self.retrieveMany(
            targets: targets,
            session: session,
            then: callback
        )
        
        return
        
    }
    
    private struct CreatePayload: Codable {
        let shop_id: String
        let human_id: String
        let active: Bool
    }
    
    private struct UpdatePayload: Codable {
        let public_id: String
        let active: Bool
    }
    
}
