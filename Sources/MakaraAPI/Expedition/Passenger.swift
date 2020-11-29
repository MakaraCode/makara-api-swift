//
//  Passenger.swift
//  
//
//  Created by Hugh Jeremy on 21/8/20.
//

import Foundation


public struct Passenger: Codable, PubliclyIdentified {
    
    public let publicId: String
    public let human: Human
    public let activities: Array<Activity>
    public let notes: Array<Note>
    public let gear: Array<Gear>
    public let disposition: Disposition
    public let paymentOutstanding: Bool
    public let packageId: String
    
    internal enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case human
        case activities
        case notes
        case gear
        case disposition
        case paymentOutstanding
        case packageId = "package_id"
    }

}
