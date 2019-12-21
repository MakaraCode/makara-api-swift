//
//  Name.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct Name: Decodable {
    
    let first: String
    let other: String?
    let last: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONObjectKeys.self)
        first = try container.decode(String.self, forKey: .first)
        other = try container.decode(String?.self, forKey: .other)
        last = try container.decode(String.self, forKey: .last)
        
    }
    
    enum JSONObjectKeys: String, CodingKey {
        case first = "first"
        case other = "other"
        case last = "last"
    }
    
}
