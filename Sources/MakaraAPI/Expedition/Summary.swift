//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 1/8/20.
//

import Foundation


public struct ExpeditionSummary: Codable {
    
    public let publicId: String
    public let locationName: String?
    public let participantCount: Int
    public let departureTime: Date
    
    internal enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case locationName = "location_name"
        case participantCount = "participant_count"
        case departureTime = "departure_time"
    }

}
