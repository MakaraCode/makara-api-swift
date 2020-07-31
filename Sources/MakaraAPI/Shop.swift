//
//  Shop.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


public struct Shop: Codable {
    
    public let publicId: String
    public let name: String?
    public let location: Location?
    public let address: Address?
    public let coverImage: Image?
    public let referenceFrame: SpatialReferenceFrame?
    public let orderBy: Shop.OrderBy
    public let disposition: Disposition
    
    internal init (
        publicId: String,
        name: String?,
        location: Location?,
        address: Address?,
        coverImage: Image?,
        referenceFrame: SpatialReferenceFrame?,
        orderBy: Shop.OrderBy,
        disposition: Disposition
    ) {
        
        self.publicId = publicId
        self.name = name
        self.location = location
        self.address = address
        self.coverImage = coverImage
        self.referenceFrame = referenceFrame
        self.orderBy = orderBy
        self.disposition = disposition
        
        return

    }
    
    public static func retrieve(
        withPublicId publicId: String,
        then callback: @escaping (_: Error?, _: Shop?) -> Void
    ) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12, execute: {
            callback(nil, Self.generateDemoShop())
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
            callback(nil, [Self.generateDemoShop()])
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
    
    private static func generateDemoShop() -> Shop {
        
        return Shop(
            publicId: "demoId_proDive",
            name: "Pro Dive Lord Howe Island",
            location: nil,
            address: nil,
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
                count: 1,
                limit: 20,
                offset: 0,
                order: .ascending
            )
        )
    }
}
