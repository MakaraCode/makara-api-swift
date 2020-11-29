//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


class Certification: Decodable {
    
    let name: String
    
    private enum Keys: String, CodingKey {
        case name = "name"
    }

}
