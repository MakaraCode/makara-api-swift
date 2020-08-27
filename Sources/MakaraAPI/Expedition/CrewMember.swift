//
//  File 2.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public class CrewMember: Decodable {
    
    let human: Human

    private enum Keys: String, CodingKey {
        case human
    }
    
}
