//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public final class Location: Journaled, Decodable {

    let journalEntry: JournalEntry
    let name: String
    let coordinates: Coordinates

    public required init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: Keys.self)
        coordinates = try data.decode(Coordinates.self, forKey: .coordinates)
        name = try data.decode(String.self, forKey: .name)
        journalEntry = try data.decode(JournalEntry.self, forKey: .journalEntry)
        return
    }

    private enum Keys: String, CodingKey {
        case journalEntry = "journal_entry"
        case name = "name"
        case coordinates = "coordinates"
    }

}
