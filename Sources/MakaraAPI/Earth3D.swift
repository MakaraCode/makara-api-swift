//
//  Earth3D.swift
//
//  Value Type representing a position on/in/above Earth in three dimensional
//  space
//

import Foundation


public struct Earth3D: Codable {
    
    let x: Float
    let y: Float
    let z: Float
    
    enum CodingKeys: String, CodingKey {
        case x = "x"
        case y = "y"
        case z = "z"
    }

}
