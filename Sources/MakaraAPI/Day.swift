//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


class Day: Decodable {
    
    let date: Date
    let dives: Array<Dive>
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        date = try MakaraDate.decode(
            apiTimeString: try  container.decode(String.self, forKey: Keys.date)
        )
        dives = try container.decode([Dive].self, forKey: Keys.dives)
        return
    }

    private enum Keys: String, CodingKey {
        case date = "date"
        case dives = "dives"
    }
    
}
