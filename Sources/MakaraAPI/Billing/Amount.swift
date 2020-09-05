//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 5/9/20.
//

import Foundation


public struct Amount: Codable {
    
    public let magnitude: Decimal
    public let iso4217: ISO4217
    
    static public func > (lhs: Amount, rhs: Amount) -> Bool {
        if (lhs.iso4217 != rhs.iso4217) { return false }
        if (lhs.magnitude > rhs.magnitude) { return true }
        return false
    }
    
    static public func > (lhs: Amount, rhs: Int) -> Bool {
        if (lhs.magnitude > Decimal(rhs)) { return true }
        return false
    }

}
