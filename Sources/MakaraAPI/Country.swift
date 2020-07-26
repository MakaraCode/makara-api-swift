//
//  File 2.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


struct Country: Codable {
    
    let name: String
    let iso3166a3: String
    let iso3166a2: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case iso3166a3 = "iso_3166_a3"
        case iso3166a2 = "iso_3166_a2"
    }

}
