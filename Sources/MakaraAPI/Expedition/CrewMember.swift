//
//  File 2.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct CrewMember: Codable, PubliclyIdentified {
    
    public let human: Human
    public let publicId: String
    public let diveId: String
    public let disposition: Disposition

    private enum Keys: String, CodingKey {
        case human
        case publicId = "public_id"
        case dispostion
    }
    
    public enum OrderBy: String {
        case name
    }

    public static let demoCrewMember1 = CrewMember(
        human: Human.demoHuman3,
        publicId: "demo_crewmember_1",
        diveId: "demo_dive_1",
        disposition: Disposition(
            sequence: 1,
            count: 1,
            limit: 50,
            offset: 0,
            order: .ascending
        )
    )
    
    public static let demoCrew = [CrewMember.demoCrewMember1]

}
