//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 17/1/21.
//

import Foundation


public struct DiveSiteProfile: Listable {
    
    internal static let path = DiveSite.path + "/profile"
    
    public let site: DiveSite
    public let shopId: String
    public let name: String?
    public let description: String?
    public let offered: Bool
    public let disposition: Disposition?
    
    public enum OrderBy: String, Codable {
        case name = "name"
        case metresFromReference = "distance"
        case modified = "modified"
    }
    
    internal enum CodingKeys: String, CodingKey {
        case site
        case shopId = "shop_id"
        case name
        case description
        case offered
        case disposition
    }
    
    public func update(
        session: Session,
        name: String? = nil,
        description: String? = nil,
        offered: Bool? = nil,
        then callback: @escaping (Error?, DiveSiteProfile?) -> Void
    ) {
        
        let payload = Payload(
            shop_id: self.shopId,
            site_id: self.site.publicId,
            offered: offered ?? self.offered,
            name: name ?? self.name,
            description: description ?? self.name
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: .POST
        ) { e, d in Request.decodeResponse(e, d, Self.self, callback) }
        
        return

    }
    
    public static func create(
        session: Session,
        shop: Shop,
        site: DiveSite,
        name: String? = nil,
        description: String? = nil,
        offered: Bool = true,
        then callback: @escaping (Error?, DiveSiteProfile?) -> Void
    ) {
        
        let payload = Payload(
            shop_id: shop.publicId,
            site_id: site.publicId,
            offered: offered,
            name: name,
            description: description
        )
        
        Request.make(
            path: Self.path,
            payload: payload,
            session: session,
            query: nil,
            method: .POST
        ) { e, d in Request.decodeResponse(e, d, Self.self, callback) }
        
        return
        
    }
    
    private struct Payload: Encodable {
        let shop_id: String
        let site_id: String
        let offered: Bool
        let name: String?
        let description: String?
    }
    
    public static func retrieve(
        session: Session,
        site: DiveSite,
        shop: Shop,
        then callback: @escaping (Error?, DiveSiteProfile?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString(targetsOnly: [
                UrlTarget(shop, key: "shop_id"),
                UrlTarget(site, key: "site_id")
            ]),
            method: .GET
        ) { (e, d) in Request.decodeResponse(e, d, Self.self, callback) }
        
        return

    }
    
    public static func retrieveMany(
        session: Session,
        shop: Shop? = nil,
        site: DiveSite? = nil,
        name: String? = nil,
        order: Order = .ascending,
        orderBy: OrderBy = .name,
        offset: Int = 0,
        limit: Int = 20,
        then callback: @escaping (Error?, Array<DiveSiteProfile>?) -> Void
    ) {
        
        let targets = [
            shop != nil ? UrlTarget(shop!, key: "shop_id") : nil,
            site != nil ? UrlTarget(site!, key: "site_id") : nil,
            name != nil ? UrlTarget(name!, key: "name_fragment") : nil,
            UrlTarget(order.rawValue, key: "order"),
            UrlTarget(orderBy.rawValue, key: "order_by"),
            UrlTarget(limit, key: "limit"),
            UrlTarget(offset, key: "offset")
        ].compactMap { $0 }
        
        Self.retrieveMany(
            targets: targets,
            session: session,
            then: callback
        )

        return

    }

}
