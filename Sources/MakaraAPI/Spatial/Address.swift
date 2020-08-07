//
//  Address.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


public struct Address: Codable {

    public let publicId: String
    public let postCode: String
    public let lines: Array<AddressLine>
    public let region: Region
    
    enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case lines = "lines"
        case postCode = "postcode"
        case region = "region"
    }

}
