//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation



class Dive: Journaled, Decodable, EntityObject {
    
    internal static let path = "/dive"
    
    let entityId: String
    let journalEntry: JournalEntry
    let start: Date
    let checkin: Date
    let location: Location?
    let crew: Array<CrewMember>
    let participants: Array<Human>
    let vehicle: Vehicle?
    
    required init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: Keys.self)
        
        journalEntry = try data.decode(JournalEntry.self, forKey: .journal)
        start = try  MakaraDate.decode(
            apiTimeString: try data.decode(String.self, forKey: .start)
        )
        checkin = try MakaraDate.decode(
            apiTimeString: try data.decode(
                String.self,
                forKey: .checkin
            )
        )
        location = try data.decode(Location?.self, forKey: .location)
        crew = try data.decode([CrewMember].self, forKey: .crew)
        participants = try data.decode([Human].self, forKey: .participants)
        vehicle = try data.decode(Vehicle?.self, forKey: .vehicle)
        entityId = try data.decode(String.self, forKey: .entityId)
        return
    }

    private enum Keys: String, CodingKey {
        case journal = "journal_entry"
        case start = "start_time"
        case checkin = "checkin_time"
        case location = "location"
        case crew = "crew"
        case participants = "participants"
        case vehicle = "vehicle"
        case entityId = "entity_id"
    }
    
}
