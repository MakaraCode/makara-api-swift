//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 23/8/20.
//

import Foundation


public protocol PubliclyIdentified: Hashable, Identifiable {

    var publicId: String { get }
    
}

extension PubliclyIdentified {
    
    public var id: String { get { return publicId } }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(publicId)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        if (lhs.publicId == rhs.publicId) { return true }
        return false
    }

}
