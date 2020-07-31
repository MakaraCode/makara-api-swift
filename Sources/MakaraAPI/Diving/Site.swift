//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 31/7/20.
//

import Foundation


struct DiveSite: Codable {
    
    let publicId: String
    let name: String
    let description: String?
    let location: Location
    let depthMetres: Int
    let referenceFrame: SpatialReferenceFrame?
    let tags: Array<Tag>
    let disposition: Disposition
    
    public enum OrderBy: String, Codable {
        case name = "name"
        case metresFromReference = "metres_from_reference"
    }
    
    internal enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case name
        case description
        case location
        case depthMetres = "depth_metres"
        case referenceFrame = "reference_frame"
        case tags
        case disposition
    }

}
