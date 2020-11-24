//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 24/11/20.
//

import Foundation


public struct PointOfInterest: Codable, Journaled {
    
    public let journalEntry: JournalEntry
    public let name: String
    public let location: Location
    public let profileImage: Image?
    public let coverImage: Image?
    public let referenceFrame: SpatialReferenceFrame?
    public let pointType: PointOfInterest.PointType
    public let disposition: Disposition
    public let orderBy: PointOfInterest.OrderBy
    
    public enum PointType: Int, Codable {
        case diveSite = 1
        case generic = 3
        case shop = 2
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

}
