//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 5/9/20.
//

import Foundation


public struct Payment: PubliclyIdentified, Codable {
    
    public let publicId: String
    public let amount: Amount
    public let method: PaymentMethod
    public let time: Date
    
    internal enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case amount
        case method
        case time
    }

}
