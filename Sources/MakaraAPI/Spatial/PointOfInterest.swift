//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 24/11/20.
//

import Foundation


public struct PointOfInterest: Codable, Journaled, Listable, Located {
    
    static internal let path = "/point-of-interest"
    
    public let journalEntry: JournalEntry
    public let name: String
    public let location: Location
    public let profileImage: Image?
    public let coverImage: Image?
    public let referenceFrame: SpatialReferenceFrame?
    public let pointType: PointOfInterest.PointType
    public let disposition: Disposition?
    public let orderBy: PointOfInterest.OrderBy
    
    public var pointOfInterest: PointOfInterest { get { return self } }
    
    public enum PointType: Int, Codable {
        case diveSite = 1
        case generic = 2
        case shop = 3
        
        internal static func toUrl(_ points: Set<Self>) -> String {
            let values = points.map { String($0.rawValue) }
            return "{" + values.joined(separator: ",") + "}"
        }
    }
    
    public enum OrderBy: String, Codable {
        case created = "created"
    }
    
    enum CodingKeys: String, CodingKey {
        case journalEntry = "journal"
        case name
        case location
        case profileImage = "profile_image"
        case coverImage = "cover_image"
        case referenceFrame = "reference_frame"
        case pointType = "point_type"
        case disposition
        case orderBy = "order_by"
    }
    
    public static func retrieveMany(
        session: Session,
        order: Order = .ascending,
        orderBy: PointOfInterest.OrderBy = .created,
        offset: Int = 0,
        limit: Int = 20,
        relatedTo shop: Shop? = nil,
        publicId: String? = nil,
        ofType pointTypes: Set<PointOfInterest.PointType>? = nil,
        then callback: @escaping (Error?, Array<PointOfInterest>?) -> Void
    ) {
        
        let targets = [
            UrlTarget(offset, key: "offset"),
            UrlTarget(limit, key: "limit"),
            UrlTarget(order.rawValue, key: "order"),
            UrlTarget(orderBy.rawValue, key: "order_by"),
            publicId != nil ? UrlTarget(publicId!, key: "public_id") : nil,
            shop != nil ? UrlTarget(
                shop!.publicId,
                key: "related_to_shop"
            ) : nil,
            pointTypes != nil ? UrlTarget(
                PointType.toUrl(pointTypes!),
                key: "of_type"
            ) : nil
        ].compactMap { $0 }
        
        Self.retrieveMany(
            targets: targets,
            session: session,
            then: callback
        )
        
        return
    }

}
