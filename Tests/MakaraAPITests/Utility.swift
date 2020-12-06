//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 13/11/20.
//

import Foundation
import XCTest
@testable import MakaraAPI


struct TestUtility {
    
    static internal func createTestEmail() -> String {
        let emailSeed = String(Int.random(in: 1..<9999999999999))
        return emailSeed + "@makara.test.nil"
    }
    
    internal static let testHumanSecret = "somethinggood"
    
    internal static func createTestHuman(
        _ expectation: XCTestExpectation,
        email: String? = nil,
        then callback: @escaping (Human) -> Void
    ) {
        
        let creationEmail = email != nil ? email! : Self.createTestEmail()
        
        Human.create(
            name: HumanName([
                HumanNameComponent(1, "Barack"),
                HumanNameComponent(2, "Obama")
            ]),
            email: creationEmail,
            secret: Self.testHumanSecret,
            session: nil,
            then: { (error, human) in
                guard let human = human else {
                    XCTFail(); expectation.fulfill(); return
                }
                guard error == nil else {
                    XCTFail(); expectation.fulfill(); return
                }
                callback(human)
                return
            }
        )
        
    }
    
    internal static func createTestSession(
        _ expectation: XCTestExpectation,
        then callback: @escaping (Human, Session) -> Void
    ) {
        
        let email = Self.createTestEmail()
        
        createTestHuman(
            expectation,
            email: email,
            then: { (human) in
    
            Session.create(
                email: email,
                secret: Self.testHumanSecret,
                then: { (error, session) in
                    
                    guard let session = session else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    
                    callback(human, session)
                    return
                }
            )
            return
        })
        
    }
    
    internal static func createTestShop(
        _ expectation: XCTestExpectation,
        then callback: @escaping (Shop, Session) -> Void
    ) {
        
        Self.createTestSession(expectation) { (human, session) in
    
            Shop.create(
                name: "Swift Test Shop",
                session: session,
                location: Location(
                    Coordinates(
                        longitude: 151.262945773938,
                        latitude: -33.89370661280347
                    ),
                    altitude: 0.0
                ),
                then: { (error, shop) in
                    guard let shop = shop else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    guard error == nil else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    callback(shop, session)
                    return
                }
            )
            
            return
        }
        
        return
        
    }
    
    internal static func createTestExpedition(
        _ expectation: XCTestExpectation,
        _ existingShop: ExistingTestShop? = nil,
        then callback: @escaping (Expedition, Session) -> Void
    ) {
        
        func create(_ shop: Shop, _ session: Session) {
                
            Expedition.create(
                checkinTime: Date(),
                checkinLocation: shop,
                departureTime: Date(),
                shop: shop,
                session: session,
                then: { (error, expedition) in
                    guard let expedition = expedition else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    guard error == nil else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    callback(expedition, session)
                    return
                })
        }
    
        if let existingShop = existingShop {
            create(existingShop.shop, existingShop.session)
            return
        }
        
    
        Self.createTestShop(expectation) { (shop, session) in
            create(shop, session)
            return
        }
        
        return
        
    }
    
    internal struct ExistingTestShop {
        let shop: Shop
        let session: Session
    }
    
    internal static func createTestTeammember(
        _ expectation: XCTestExpectation,
        _ existingShop: ExistingTestShop? = nil,
        then callback: @escaping (Teammember, Session) -> Void
    ) {
        
        func create(_ shop: Shop, _ session: Session) {
            Self.createTestHuman(expectation) { (human) in
                Teammember.create(
                    shop: shop,
                    human: human,
                    session: session,
                    callback: { (error, teammember) in
                        guard let teammember = teammember else {
                            XCTFail(); expectation.fulfill(); return
                        }
                        callback(teammember, session)
                        return
                    }
                )
            }
        }
        
        if let existing = existingShop {
            create(existing.shop, existing.session)
            return
        }

        TestUtility.createTestShop(expectation) { (shop, session) in
            create(shop, session)
            return
        }
        return

    }
    
    internal struct ExistingTestExpedition {
        let expedition: Expedition
        let session: Session
    }
    
    internal struct ExistingTestTeammember {
        let teammember: Teammember
        let session: Session
    }
    
    internal static func createTestCrewmember(
        _ expectation: XCTestExpectation,
        _ existingExpedition: ExistingTestExpedition? = nil,
        _ existingTeammember: ExistingTestTeammember? = nil,
        _ existingShop: ExistingTestShop? = nil,
        then callback: @escaping (CrewMember, Session) -> Void
    ) {
        
        func create(
            _ expedition: Expedition,
            _ session: Session,
            _ teammember: Teammember
        ) {
            
            CrewMember.create(
                session: session,
                teammember: teammember,
                expedition: expedition,
                role: .captain,
                callback: { (error, crewmember) in
                    guard let crewmember = crewmember else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    callback(crewmember, session)
                    return
                }
            )
            
            return
            
        }
        
        func stageExpedition(_ expedition: Expedition, _ session: Session) {
            if let existingTeammember = existingTeammember {
                create(expedition, session, existingTeammember.teammember)
                return
            }
            
            TestUtility.createTestTeammember(
                expectation,
                existingShop,
                then: { (teammember, session) in
                    create(expedition, session, teammember)
                    return
                }
            )
            
            return
        }
        
        if let existingExpedition = existingExpedition {
            stageExpedition(
                existingExpedition.expedition,
                existingExpedition.session
            )
            return
        }
        
        TestUtility.createTestExpedition(
            expectation,
            existingShop,
            then: { (expedition, session) in
                stageExpedition(expedition, session)
                return
            }
        )
        
        return
        
    }

}
