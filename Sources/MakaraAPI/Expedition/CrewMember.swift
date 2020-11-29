//
//  File 2.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct CrewMember: Codable, PubliclyIdentified {
    
    public let human: Human
    public let publicId: String
    public let expeditionId: String
    public let orderBy: CrewMember.OrderBy
    public let disposition: Disposition

    private enum CodingKeys: String, CodingKey {
        case human
        case publicId = "public_id"
        case expeditionId = "expedition_id"
        case orderBy = "order_by"
        case disposition
    }
    
    public enum OrderBy: String, Codable {
        case name
    }

}
