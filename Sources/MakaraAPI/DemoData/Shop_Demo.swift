//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension Shop {

    public static var demoShop: Shop { return Self.demoShop1; }
    public static let demoShops: Array<Shop> = [Self.demoShop1, Self.demoShop2]
    
    public static let demoShop1 = Shop(
        journalEntry: JournalEntry(
            publicId: "demoId_proDive",
            created: Date(),
            creatingAgentId: "100"
        ),
        pointOfInterest: PointOfInterest.demo,
        address: Address(
            publicId: "demo_address_proDive",
            postCode: "2898",
            lines: [
                AddressLine(body: "Lagoon Road"),
                AddressLine(body: "Lord Howe Island")
            ],
            region: Region.AU_NSW
        ),
        disposition: Disposition(
            sequence: 2,
            count: 2,
            limit: 20,
            offset: 0,
            order: .ascending
        ),
        orderBy: .name
    )
    
    public static let demoShop2 = Shop(
        journalEntry: JournalEntry(
            publicId: "demoId_diveCenterBondi",
            created: Date(),
            creatingAgentId: "100"
        ),
        pointOfInterest: PointOfInterest.demo2,
        address: Address(
            publicId: "demo_address_diveCenterBondi",
            postCode: "2026",
            lines: [
                AddressLine(body: "198 Bondi Rd"),
                AddressLine(body: "Bondi")
            ],
            region: Region.AU_NSW
        ),
        disposition: Disposition(
            sequence: 2,
            count: 2,
            limit: 20,
            offset: 0,
            order: .ascending
        ),
        orderBy: .name
    )
    
}
