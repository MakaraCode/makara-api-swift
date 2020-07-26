//
//  Address.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


struct Address: Codable {

    let publicId: String
    let postCode: String
    let lines: Array<AddressLine>
    let region: Region
    
    enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case lines = "lines"
        case postCode = "postcode"
        case region = "region"
    }

}
