//
//  Shop.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


public class Shop: Codable {
    
    let publicId: String
    let name: String?
    let location: Location?
    let address: Address?
    let coverImage: Media?
    
    internal init (
        publicId: String,
        name: String?,
        location: Location?,
        address: Address?,
        coverImage: Media?
    ) {
        
        self.publicId = publicId
        self.name = name
        self.location = location
        self.address = address
        self.coverImage = coverImage

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
    
    private static func generateDemoShop() -> Shop {
        
        return Shop(
            publicId: "demoId_proDive",
            name: "Pro Dive Lord Howe Island",
            location: nil,
            address: nil,
            coverImage: Media(
                publicId: "demo_proDive_image",
                mediaType: .image,
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
            )
        )
        
    }
    
}
