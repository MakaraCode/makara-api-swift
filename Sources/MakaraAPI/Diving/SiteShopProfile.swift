//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 24/11/20.
//

import Foundation


public struct SiteShopProfile: Codable {
    
    public let shopId: String
    public let offered: Bool
    public let profileImage: Image?
    public let coverImage: Image?
    public let name: String?
    public let description: String?

    internal enum CodingKeys: String, CodingKey {
        case shopId = "shop_id"
        case offered
        case profileImage = "profile_image"
        case coverImage = "cover_image"
        case name
        case description
    }
    
}
