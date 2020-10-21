//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 31/7/20.
//

import Foundation


public struct DiveSite: Codable, PubliclyIdentified {
    
    public let publicId: String
    public let name: String
    public let description: String?
    public let location: Location
    public let depthMetres: Int
    public let referenceFrame: SpatialReferenceFrame?
    public let tags: Array<Tag>
    public let disposition: Disposition
    
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
    
    public static let demoSite1 = DiveSite(
        publicId: "demo_divesite_1",
        name: "The Arch",
        description: nil,
        location: Location(
            coordinates: Coordinates(
                longitude: "-31.527473",
                latitude: "159.066132"
            ),
            earth3d: Earth3D(x: 1.0, y: 1.0, z: 1.0)
        ),
        depthMetres: 5,
        referenceFrame: SpatialReferenceFrame(
            location: Location(
                coordinates: Coordinates(
                    longitude: "-31.527866",
                    latitude: "159.049642"
                ),
                earth3d: Earth3D(x: 1.0, y: 1.0, z: 1.0)
            ),
            distanceMetres: 7900
        ),
        tags: [Tag(body: "Blue", count: 4)],
        disposition: Disposition(
            sequence: 1,
            count: 1,
            limit: 1,
            offset: 0,
            order: .descending
        )
    )

}
