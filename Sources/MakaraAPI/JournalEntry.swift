//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation

public struct JournalEntry: Codable {
    
    let publicId: String
    let created: Date
    let creatingAgentId: String

    enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case created = "created"
        case creatingAgentId = "creating_agent"
    }
    
}
