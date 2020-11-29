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

}
