//
//  Human.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct Human: Codable, PubliclyRetrievable, Listable {
    
    public static let path = "/human"
    
    public let publicId: String
    public let name: HumanName
    public let birthDate: Date?
    public let email: String?

    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case name
        case birthDate = "birth_date"
        case email
    }
    
    public static func create(
        name: HumanName,
        email: String,
        secret: String?,
        session: Session?,
        then callback: @escaping (Error?, Human?) -> Void
    ) {
       
        Request.make(
            path: Self.path,
            payload: Self.CreatePayload(
                email: email,
                name: name,
                secret: secret
            ),
            session: session,
            query: nil,
            method: HTTPMethod.POST,
            then: { (error: Error?, data: Data?) -> Void in
                Request.decodeResponse(error, data, Self.self, callback)
                return
            }
        )
        
        return

    }
    
    public static func retrieveMany(
        session: Session,
        order: Order = .ascending,
        orderBy: Human.OrderBy = .name,
        offset: Int = 0,
        limit: Int = 20,
        accessibleTo shop: Shop? = nil,
        nameFragment name: String? = nil,
        then callback: @escaping (Error?, Array<Human>?) -> Void
    ) {
        
        let targets = [
            UrlTarget(offset, key: "offset"),
            UrlTarget(limit, key: "limit"),
            UrlTarget(order.rawValue, key: "order"),
            UrlTarget(orderBy.rawValue, key: "order_by"),
            shop != nil ? UrlTarget(shop!, key: "shop_id") : nil,
            name != nil ? UrlTarget(name!, key: "name_fragment") : nil
        ].compactMap { $0 }
        
        Self.retrieveMany(targets: targets, session: session, then: callback)
        
        return

    }

    public enum OrderBy: String, CodingKey {
        case name = "name"
    }

    fileprivate struct CreatePayload: Codable {
        let email: String
        let name: HumanName
        let secret: String?
    }

}
