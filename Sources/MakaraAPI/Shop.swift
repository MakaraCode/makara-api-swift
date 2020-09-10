//
//  Shop.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


public struct Shop: Codable, Hashable, Identifiable {
    
    public let publicId: String
    public let name: String
    public let location: Location?
    public let address: Address?
    public let coverImage: Image?
    public let referenceFrame: SpatialReferenceFrame?
    public let orderBy: Shop.OrderBy
    public let disposition: Disposition
    
    public var id: String { get { return publicId } }
    
    public static func retrieve(
        withPublicId publicId: String,
        then callback: @escaping (_: Error?, _: Shop?) -> Void
    ) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12, execute: {
            callback(nil, self.demoShop1)
        })
        
        return
    }
    
    public static func retrieveMany(
        nameFragment: String? = nil,
        referenceLocation: Coordinates? = nil,
        order: Order = .ascending,
        orderBy: Shop.OrderBy = .name,
        offset: Int = 0,
        limit: Int = 20,
        then callback: @escaping (_: Error?, _: Array<Shop>?) -> Void
    ) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12, execute: {
            callback(nil, [Self.demoShop1])
        })
        
        return
        
    }
    
    public static func create(
        name: String,
        location: Location? = nil,
        address: Address? = nil,
        then callback: @escaping (_: Error?, _: Shop?) -> Void
    ) {
        fatalError("Not implemented")
    }
    
    public enum OrderBy: String, Codable {
        case name = "name"
        case created = "created"
        case metresFromReference = "metres_from_reference"
    }
    
    enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case name = "name"
        case location = "location"
        case address = "address"
        case coverImage = "cover_image"
        case referenceFrame = "reference_frame"
        case orderBy = "order_by"
        case disposition = "disposition"
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
        publicId: "demoId_proDive",
        name: "Pro Dive Lord Howe Island",
        location: nil,
        address: Address(
            publicId: "demo_address_proDive",
            postCode: "2898",
            lines: [
                AddressLine(body: "Lagoon Road"),
                AddressLine(body: "Lord Howe Island")
            ],
            region: Region.AU_NSW
        ),
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
        orderBy: .name,
        disposition: Disposition(
            sequence: 1,
            count: 2,
            limit: 20,
            offset: 0,
            order: .ascending,
            orderBy: "name"
        )
    )
    
    public static let demoShop2 = Shop(
        publicId: "demoId_diveCenterBondi",
        name: "Dive Centre Bondi",
        location: nil,
        address: Address(
            publicId: "demo_address_diveCenterBondi",
            postCode: "2026",
            lines: [
                AddressLine(body: "198 Bondi Rd"),
                AddressLine(body: "Bondi")
            ],
            region: Region.AU_NSW
        ),
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
            tags: [Tag(body: "beach", count: 3)]
        ),
        referenceFrame: nil,
        orderBy: .name,
        disposition: Disposition(
            sequence: 2,
            count: 2,
            limit: 20,
            offset: 0,
            order: .ascending,
            orderBy: "name"
        )
    )

}
