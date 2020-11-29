//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


protocol Journaled: PubliclyIdentified {
    
    var journalEntry: JournalEntry { get }

}

extension Journaled {
    
    public var created: Date { get { return self.journalEntry.created } }
    public var publicId: String { get {
        return self.journalEntry.publicId
    } }
    public var creatingAgentId: String { get {
        return self.journalEntry.creatingAgentId
    } }
    
}

