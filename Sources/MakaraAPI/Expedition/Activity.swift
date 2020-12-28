//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 27/8/20.
//

import Foundation


public enum Activity: Int, Codable {
    
    case dive = 1
    case snorkel = 2
    case swim = 3
    
    public var name: String { get {
        switch self {
        case .dive:
            return "dive"
        case .snorkel:
            return "snorkel"
        case .swim:
            return "swim"
        }
    } }

}
