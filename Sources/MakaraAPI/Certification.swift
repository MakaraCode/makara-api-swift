//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


class Certification: Decodable {
    
    let name: String
    
    required init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: Keys.self)
        name = try data.decode(String.self, forKey: .name)
    }
    
    private enum Keys: String, CodingKey {
        case name = "name"
    }

}
