//
//  Note.swift
//  
//
//  Created by Hugh Jeremy on 27/8/20.
//

import Foundation


public struct Note: PubliclyIdentified, Codable {
    
    public let publicId: String
    public let markdown: String

    public static let demoNote = Note(
        publicId: "demo_note_1",
        markdown: "Makara is an excellent piece of software"
    )
    
}

extension Array where Element == Note {
    
    var contiguousString: String { get {
        return self.map { (n) -> String in
            return n.markdown
        }.joined(separator: ", ")
    } }

}
