//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 27/8/20.
//

import Foundation


public struct GearDifferentiator: Codable, Identifiable {
    
    public let id: Int
    public let name: DifferentiatorName
    public let differentiatorClass: DifferentiatorClass
    public let manufacturer: Manufacturer
    public let value: String
    
    static let demoUniSex = GearDifferentiator(
        id: 1,
        name: .sex,
        differentiatorClass: .semantic,
        manufacturer: .generic,
        value: "Unisex"
    )
    
    static let demoWetsuitThickness051mm = GearDifferentiator(
        id: 8,
        name: .thickness,
        differentiatorClass: .integral,
        manufacturer: .generic,
        value: "0.5 - 1 mm"
    )

}
