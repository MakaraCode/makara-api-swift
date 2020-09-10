//
//  Region.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


public struct Region: Codable {

    public let name: String
    public let abbreviation: String
    public let country: Country
    public let indexid: String
    
    public var summary: String { get {
        return self.abbreviation + ", " + self.country.name
    } }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case indexid = "indexid"
        case abbreviation = "abbreviation"
        case country = "country"
    }
    
    public static let AU_NSW = Region(
        name: "New South Wales",
        abbreviation: "NSW",
        country: Country(
            name: "Australia", iso3166a3:
            "aus",
            iso3166a2: "au"
        ),
        indexid: "1"
    )

}
