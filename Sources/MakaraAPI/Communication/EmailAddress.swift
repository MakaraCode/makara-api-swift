//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


struct EmailAddress: Journaled, Decodable {
        
    let journalEntry: JournalEntry
    let email: String
    let verified: Date?
    let requiresVerification: Bool
    
    var isConfirmed: Bool {
        get { return self.verified != nil }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONObjectKeys.self)
        email = try container.decode(String.self, forKey: .email)
        verified = try MakaraDate.optionallyDecode(
            apiTimeString: try container.decode(String?.self, forKey: .verified)
        )
        requiresVerification = try container.decode(
            Bool.self,
            forKey: .requiresVerification
        )
        journalEntry = try container.decode(JournalEntry.self, forKey: .journal)
        return
    }
    
    enum JSONObjectKeys: String, CodingKey {
        case journal = "JournalEntry"
        case email = "email"
        case verified = "verified"
        case requiresVerification = "requires_verification"
    }

}
