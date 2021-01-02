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
        _ session: Session? = nil,
        email: String? = nil,
        then callback: @escaping (Human, Session) -> Void
    ) {
        
        let creationEmail = email != nil ? email! : Self.createTestEmail()
        
        Human.create(
            name: HumanName([
                HumanNameComponent(1, "Barack"),
                HumanNameComponent(2, "Obama")
            ]),
            email: creationEmail,
            secret: Self.testHumanSecret,
            session: session,
            then: { (error, human) in
                guard let human = human else {
                    XCTFail(); expectation.fulfill(); return
                }
                guard error == nil else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                if let session = session {
                    callback(human, session)
                    return
                }
                
                Session.create(
                    email: creationEmail,
                    secret: Self.testHumanSecret
                ) { (error, session) in
                    guard let session = session else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    callback(human, session)
                    return
                }

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
            then: { (human, session) in
                callback(human, session)
            return
        })
        
    }
    
    internal static func createTestShop(
        _ expectation: XCTestExpectation,
        _ existingSession: Session? = nil,
        then callback: @escaping (Shop, Session) -> Void
    ) {
        
        func stageSession(session: Session) {
            
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

        }
        
        if let existingSession = existingSession {
            stageSession(session: existingSession)
            return
        }
        
        Self.createTestSession(expectation) { (human, session) in
            stageSession(session: session)
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
            Self.createTestHuman(expectation, session) { (human, _) in
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
            
            Shop.retrieve(
                withPublicId: expedition.shopId,
                session: session
            ) { (error, shop) in
                guard let shop = shop else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                TestUtility.createTestTeammember(
                    expectation,
                    existingShop ?? ExistingTestShop(
                        shop: shop, session: session
                    ),
                    then: { (teammember, session) in
                        create(expedition, session, teammember)
                        return
                    }
                )
                
            }
        
            
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
    
    internal static func createTestLeg(
        _ expectation: XCTestExpectation,
        then callback: @escaping (Leg, Session) -> Void
    ) {
        
        Self.createTestExpedition(expectation) { (expedition, session) in

            Leg.create(
                session: session,
                expedition: expedition,
                sequence: 1
            ) { (error, leg) in

                guard let leg = leg else {
                    expectation.fulfill()
                    XCTFail()
                    return
                }

                guard error == nil else {
                    expectation.fulfill()
                    XCTFail()
                    return
                }
                callback(leg, session)

                return
            }

        }
        
        return

    }
    
    internal struct ExistingLeg {
        let session: Session
        let leg: Leg
    }
    
    internal static func createTestParticipant(
        _ expectation: XCTestExpectation,
        expedition: Expedition? = nil,
        existingLeg: ExistingLeg? = nil,
        human: Human? = nil,
        then callback: @escaping (Participant, Session) -> Void
    ) {
        
        func stageHuman(
            _ leg: Leg,
            _ human: Human,
            _ session: Session
        ) {
            
            Participant.create(
                session: session,
                leg: leg,
                human: human,
                activities: [.dive]
            ) { (error, participant) in
                
                guard let participant = participant else {
                    XCTFail(); expectation.fulfill(); return
                }

                callback(participant, session)
                
                return
                
            }
            
            return
            
        }
        
        func stageLeg(
            _ leg: Leg,
            _ session: Session
        ) {
            if let human = human {
                stageHuman(leg, human, session)
                return
            }
            
            TestUtility.createTestHuman(expectation) { (human, _) in
                stageHuman(leg, human, session)
                return
            }
            
            return
        }
    
        if let existing = existingLeg {
            stageLeg(
                existing.leg,
                existing.session
            )
            return
        }
        
        Self.createTestLeg(expectation) { (leg, session) in
           stageLeg(leg, session)
        }
        
        return

    }

}
