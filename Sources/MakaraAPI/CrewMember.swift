//
//  File 2.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public class CrewMember: Journaled, Decodable {
    
    let human: Human
    let journalEntry: JournalEntry
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        human = try container.decode(Human.self, forKey: Keys.human)
        journalEntry = try container.decode(
            JournalEntry.self,
            forKey: Keys.journalEntry
        )
        return
    }
    
    private enum Keys: String, CodingKey {
        case human = "human"
        case journalEntry = "journal_entry"
    }
    
}
