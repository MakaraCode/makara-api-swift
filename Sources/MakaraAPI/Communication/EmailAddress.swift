//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


struct EmailAddress: Journaled, Codable {
        
    let journalEntry: JournalEntry
    let email: String
    let verified: Date?
    let requiresVerification: Bool
    
    var isConfirmed: Bool {
        get { return self.verified != nil }
    }
    
    enum CodingKeys: String, CodingKey {
        case journalEntry = "JournalEntry"
        case email = "email"
        case verified = "verified"
        case requiresVerification = "requires_verification"
    }

}
