//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public class Human: Agent, Journaled, Decodable {

    let name: Name
    let publicId: String
    var agentId: String { get { return self.publicId } }
    let contactCard: ContactCard
    let certifications: Array<Certification>
    let journalEntry: JournalEntry

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        name = try container.decode(Name.self, forKey: .name)
        journalEntry = try container.decode(
            JournalEntry.self, forKey: .journalEntry
        )
        contactCard = try container.decode(
            ContactCard.self, forKey: .contactCard
        )
        certifications = try container.decode(
            [Certification].self, forKey: .certifications
        )
        publicId = try container.decode(String.self, forKey: .publicId)
        return
    }
    
    private enum Keys: String, CodingKey {
        case publicId = "public_id"
        case journalEntry = "journal_entry"
        case name = "name"
        case contactCard = "contact_card"
        case certifications = "certifications"
    }

}
