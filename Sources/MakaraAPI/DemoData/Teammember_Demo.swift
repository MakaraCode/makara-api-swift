//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 6/12/20.
//

import Foundation


extension Teammember {
    
    public static let demo = Teammember(
        journalEntry: JournalEntry(
            publicId: "demo_teammember_1",
            created: Date(),
            creatingAgentId: Human.demoHuman1.publicId
        ),
        human: Human.demoHuman1,
        shopId: Shop.demoShop.publicId,
        active: true,
        disposition: nil
    )
    
}
