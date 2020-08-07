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
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case indexid = "indexid"
        case abbreviation = "abbreviation"
        case country = "country"
    }

}
