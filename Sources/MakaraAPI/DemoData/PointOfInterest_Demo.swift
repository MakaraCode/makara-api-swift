//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension PointOfInterest {
    
    static let demo = PointOfInterest(
        journalEntry: JournalEntry(
            publicId: "demoId_proDive",
            created: Date(),
            creatingAgentId: "100"
        ),
        name: "Pro Dive Lord Howe Island",
        location: Location(
            Coordinates(
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
    )
    
    static let demo2 = PointOfInterest(
        journalEntry: JournalEntry(
            publicId: "demoId_diveCenterBondi",
            created: Date(),
            creatingAgentId: "100"
        ),
        name: "Dive Centre Bondi",
        location: Location(
            Coordinates(
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
    )
    
}
