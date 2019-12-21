//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


protocol Journaled {
    
    var journalEntry: JournalEntry { get }

}

extension Journaled {
    
    var created: Date { get { return self.journalEntry.created } }
    var publicId: String { get {
        return self.journalEntry.publicId
    } }
    var creatingAgent: Agent { get {
        return self.journalEntry.creatingAgent
    } }
    
}
