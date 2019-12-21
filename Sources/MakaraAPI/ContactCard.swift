//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


struct ContactCard: Decodable {
    
    let phone: PhoneNumber?
    let emailAddress: EmailAddress?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONObjectKeys.self)
        phone = try container.decode(PhoneNumber?.self, forKey: .phone)
        emailAddress = try container.decode(EmailAddress?.self, forKey: .email)
    }
    
    enum JSONObjectKeys: String, CodingKey {
        case phone = "phone_number"
        case email = "email_address"
    }

}
