//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


struct Day: Codable {
    
    let date: Date
    let notes: String
    let expeditions: Array<ExpeditionSummary>
    

    private enum Keys: String, CodingKey {
        case date = "date"
        case expeditions
    }
    
}
