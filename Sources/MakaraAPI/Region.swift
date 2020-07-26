//
//  Region.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


struct Region: Codable {

    let name: String
    let abbreviation: String
    let country: Country
    let indexid: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case indexid = "indexid"
        case abbreviation = "abbreviation"
        case country = "country"
    }

}
