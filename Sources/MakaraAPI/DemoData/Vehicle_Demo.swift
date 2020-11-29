//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension Vehicle {
    
    public static var demoVehicle1: Vehicle { get {
        return Vehicle(
            publicId: "demo_vehicle_1",
            type: .boat,
            maximumPassengers: 12,
            minimumCrew: 2,
            name: "Pinnacle"
        )
    } }
        
    public static var demoVehicle2: Vehicle { get {
        return Vehicle(
            publicId: "demo_vehicle_2",
            type: .truck,
            maximumPassengers: 6, minimumCrew: 1,
            name: "Ute"
        )
    } }
    
    public static var demoVehicles: Array<Vehicle> { get {
        return [Self.demoVehicle1, Self.demoVehicle2]
    } }
    
}
