//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation

internal struct JournalEntry: Decodable {
    
    let publicId: String
    let created: Date
    let creatingAgent: Agent
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONObjectKeys.self)
        let agentId = try container.decode(String.self, forKey: .creatingAgent)
        creatingAgent = StandaloneAgent(withId: agentId)
        let rawTime = try container.decode(String.self, forKey: .created)
        created = try MakaraDate.decode(apiTimeString: rawTime)
        publicId = try container.decode(String.self, forKey: .publicId)
        return
    }

    enum JSONObjectKeys: String, CodingKey {
        case publicId = "public_id"
        case created = "created"
        case creatingAgent = "creating_agent_id"
    }
    
}
