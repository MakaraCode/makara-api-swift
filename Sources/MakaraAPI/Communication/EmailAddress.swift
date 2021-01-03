//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct EmailAddress: Journaled, Codable {
    
    public static let regexPattern =
        #"^[A-Z0-9._%+-]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$"#
    
    public static let foo = #"\bClue(do)?™?\b"#
        
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
    
    public static func appearsValid(_ string: String) -> Bool {
        if string.count < 1 { return false }
        return string.range(
            of: Self.regexPattern,
            options: [.regularExpression, .caseInsensitive]
        ) != nil
    }

}
