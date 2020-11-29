//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension Dive {

    public static let demoDive1 = Dive(
        publicId: "demo_dive_1",
        site: DiveSite.demoSite1,
        disposition:Disposition(
            sequence: 1,
            count: 2,
            limit: 50,
            offset: 0,
            order: .ascending
        )
    )
    
    public static let demoDive2 = Dive(
        publicId: "demo_dive_2",
        site: DiveSite.demoSite1,
        disposition: Disposition(
            sequence: 2,
            count: 2,
            limit: 50,
            offset: 0,
            order: .ascending
        )
    )
    
    public static let demoDives = [Dive.demoDive1, Dive.demoDive2]
    
}
