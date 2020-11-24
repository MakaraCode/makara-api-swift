//
//  Shop.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


public struct Shop: Codable, Journaled, Located {
    
    internal static let path = "/shop"
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
    
    public static func retrieve(
        withPublicId publicId: String,
        session: Session,
        then callback: @escaping (Error?, Shop?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [
                    UrlTarget(stringValue: publicId, key: "public_id")
                ]
            ),
            method: HTTPMethod.GET,
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
    
    public static var demoShop: Shop { return Self.demoShop1; }
    public static let demoShops: Array<Shop> = [Self.demoShop1, Self.demoShop2]
    
    public static let demoShop1 = Shop(
        journalEntry: JournalEntry(
            publicId: "demoId_proDive",
            created: Date(),
            creatingAgentId: "100"
        ),
        pointOfInterest: PointOfInterest(
            journalEntry: JournalEntry(
                publicId: "demoId_proDive",
                created: Date(),
                creatingAgentId: "100"
            ),
            name: "Pro Dive Lord Howe Island",
            location: Location(
                coordinates: Coordinates(
                    longitude: 151.262945773938,
                    latitude: -33.89370661280347
                ),
                altitude: 0.0
            ),
            profileImage: nil,
            coverImage: Image(
                publicId: "demo_proDive_image",
                mediaQuality: .managed,
                mediaCodec: .jpeg,
                url: "https://blinkybeach.com/img/proDiveDemo.jpeg",
                dimensions: [
                    MediaDimension(dimensionType: .xPixels, value: 2560),
                    MediaDimension(dimensionType: .yPixels, value: 1920),
                    MediaDimension(dimensionType: .sizeKb, value: 623)
                ],
                name: nil,
                description: nil,
                tags: [Tag(body: "island", count: 4)]
            ),
            referenceFrame: nil,
            pointType: .shop,
            disposition: Disposition(
                sequence: 1,
                count: 1,
                limit: 1,
                offset: 0,
                order: .ascending
            ),
            orderBy: .created
        ),
        address: Address(
            publicId: "demo_address_proDive",
            postCode: "2898",
            lines: [
                AddressLine(body: "Lagoon Road"),
                AddressLine(body: "Lord Howe Island")
            ],
            region: Region.AU_NSW
        ),
        disposition: Disposition(
            sequence: 2,
            count: 2,
            limit: 20,
            offset: 0,
            order: .ascending
        ),
        orderBy: .name
    )
    
    public static let demoShop2 = Shop(
        journalEntry: JournalEntry(
            publicId: "demoId_diveCenterBondi",
            created: Date(),
            creatingAgentId: "100"
        ),
        pointOfInterest: PointOfInterest(
            journalEntry: JournalEntry(
                publicId: "demoId_diveCenterBondi",
                created: Date(),
                creatingAgentId: "100"
            ),
            name: "Dive Centre Bondi",
            location: Location(
                coordinates: Coordinates(
                    longitude: 151.262945773938,
                    latitude: -33.89370661280347
                ),
                altitude: 0.0
            ),
            profileImage: Image(
                publicId: "demo_proDive_image",
                mediaQuality: .managed,
                mediaCodec: .jpeg,
                url: "https://blinkybeach.com/img/proDiveDemo.jpeg",
                dimensions: [
                    MediaDimension(dimensionType: .xPixels, value: 2560),
                    MediaDimension(dimensionType: .yPixels, value: 1920),
                    MediaDimension(dimensionType: .sizeKb, value: 623)
                ],
                name: nil,
                description: nil,
                tags: [Tag(body: "beach", count: 3)]
            ),
            coverImage: nil,
            referenceFrame: nil,
            pointType: .shop,
            disposition: Disposition(
                sequence: 1,
                count: 1,
                limit: 1,
                offset: 0,
                order: .ascending
            ),
            orderBy: .created
        ),
        address: Address(
            publicId: "demo_address_diveCenterBondi",
            postCode: "2026",
            lines: [
                AddressLine(body: "198 Bondi Rd"),
                AddressLine(body: "Bondi")
            ],
            region: Region.AU_NSW
        ),
        disposition: Disposition(
            sequence: 2,
            count: 2,
            limit: 20,
            offset: 0,
            order: .ascending
        ),
        orderBy: .name
    )

}
