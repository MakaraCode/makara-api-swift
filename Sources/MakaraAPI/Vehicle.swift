//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


class Vehicle: Decodable {
    
    let passengerCapacity: Int
    let name: String

    required init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: Keys.self)
        passengerCapacity = try data.decode(
            Int.self, forKey: .passengerCapacity
        )
        name = try data.decode(String.self, forKey: .name)
        return
    }

    private enum Keys: String, CodingKey {
        case passengerCapacity = "passenger_capacity"
        case name = "name"
    }
}
