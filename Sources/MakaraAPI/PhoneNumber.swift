//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation

public class PhoneNumber: Journaled, Decodable {

    let journalEntry: JournalEntry
    let digits: String
    let verified: Date?
    let requiresConfirmation: Bool

    var isConfirmed: Bool {
        get { return self.verified != nil }
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        journalEntry = try container.decode(JournalEntry.self, forKey: .journal)
        digits = try container.decode(String.self, forKey: .digits)
        verified = try MakaraDate.optionallyDecode(
            apiTimeString: try container.decode(
                String.self, forKey: Keys.verified
            )
        )
        requiresConfirmation = try container.decode(
            Bool.self,
            forKey: .requiresVerification
        )
        return
    }

    internal enum Keys: String, CodingKey {
        case journal = "journal_entry"
        case digits = "digits"
        case verified = "verified"
        case requiresVerification = "requires_verification"
    }

}
