//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation

public class PhoneNumber: Journaled, Codable {

    let journalEntry: JournalEntry
    let digits: String
    let verified: Date?
    let requiresVerification: Bool

    var isConfirmed: Bool {
        get { return self.verified != nil }
    }

    internal enum CodingKeys: String, CodingKey {
        case journalEntry = "journal"
        case digits = "digits"
        case verified = "verified"
        case requiresVerification = "requires_verification"
    }

}
