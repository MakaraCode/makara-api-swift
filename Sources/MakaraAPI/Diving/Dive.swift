//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 24/8/20.
//

import Foundation


public struct Dive: Codable, PubliclyIdentified {
    
    public let publicId: String
    public let site: DiveSite?
    public let disposition: Disposition
    
    private enum CodingKeys: String, CodingKey {
        
        case publicId = "public_id"
        case site
        case disposition

    }

}
