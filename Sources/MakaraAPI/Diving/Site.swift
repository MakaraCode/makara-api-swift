//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 31/7/20.
//

import Foundation


public struct DiveSite: Codable, Journaled, Located {
    
    internal static let path = "/dive-site"
    
    public let journalEntry: JournalEntry
    public let pointOfInterest: PointOfInterest
    public let description: String?
    public let shopProfile: SiteShopProfile?
    public let tags: Array<Tag>
    public let disposition: Disposition
    public let orderBy: DiveSite.OrderBy
    
    public enum OrderBy: String, Codable {
        case name = "name"
        case metresFromReference = "metres_from_reference"
        case created = "created"
    }

    internal enum CodingKeys: String, CodingKey {
        case journalEntry = "journal"
        case pointOfInterest = "point_of_interest"
        case shopProfile = "shop_profile"
        case description
        case tags
        case disposition
        case orderBy = "order_by"
    }
    
    public static let demoSite1 = DiveSite(
        journalEntry: JournalEntry(
            publicId: "demo_divesite_1",
            created: Date(),
            creatingAgentId: "100"
        ),
        pointOfInterest: PointOfInterest(
            journalEntry: JournalEntry(
                publicId: "demo_divesite_1",
                created: Date(),
                creatingAgentId: "100"
            ),
            name: "The Arch",
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
        ),
        description: nil,
        shopProfile: nil,
        tags: [Tag(body: "Blue", count: 4)],
        disposition: Disposition(
            sequence: 1,
            count: 1,
            limit: 1,
            offset: 0,
            order: .descending
        ),
        orderBy: .name
    )

}
