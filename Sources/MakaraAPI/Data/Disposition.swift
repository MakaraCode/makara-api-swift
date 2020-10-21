//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/7/20.
//

import Foundation


public struct Disposition: Codable {
    
    public let sequence: Int
    public let count: Int
    public let limit: Int
    public let offset: Int
    public let order: Order

}
