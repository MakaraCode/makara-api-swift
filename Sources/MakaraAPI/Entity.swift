//
//  File 2.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public class Entity {
    
    private static let path = "/entities"
    
    private let attributes: Entity.Attributes
    private let session: Session
    
    var publicId: String { get { return self.attributes.publicId } }
    var name: String { get { return self.attributes.name } }
    var active: Bool { get { return self.attributes.active} }
    
    internal init(
        _ session: Session,
        _ attributes: Entity.Attributes
    ) {
        self.session = session
        self.attributes = attributes
        return
    }
    
    internal struct Attributes: Decodable {
        
        let publicId: String
        let name: String
        let active: Bool
        
        internal init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: JSONObjectKeys.self)
            publicId = try container.decode(String.self, forKey: .publicId)
            name = try container.decode(String.self, forKey: .name)
            active = try container.decode(Bool.self, forKey: .active)
            return
        }
        
        enum JSONObjectKeys: String, CodingKey {
            case publicId = "public_id"
            case name = "name"
            case active = "active"
        }
    }

}
