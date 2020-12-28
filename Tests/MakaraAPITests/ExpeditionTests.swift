//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 28/11/20.
//

import XCTest
@testable import MakaraAPI

final class MakaraAPI_ExpeditionTests: XCTestCase {
    
    static func receiveExpedition(
        _ error: Error?,
        _ expedition: Expedition?,
        _ expectation: XCTestExpectation
    ) {
        XCTAssertNil(error)
        XCTAssertNotNil(expedition)
        expectation.fulfill()
        return
    }
    
    func testCreateExpedition() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestShop(expectation) { (shop, session) in
            Expedition.create(
                checkinTime: Date(),
                checkinLocation: shop,
                departureTime: Date(),
                shop: shop,
                session: session,
                then: { (error, expedition) in
                    Self.receiveExpedition(error, expedition, expectation)
                    return
            })
        }
        
        wait(for: [expectation], timeout: 5)
        return
    }
    
    func testRetrieveExpedition() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestExpedition(expectation) { (created, session) in
            
            Expedition.retrieve(
                withPublicId: created.publicId,
                session: session,
                then: { (error, expedition) in
                    Self.receiveExpedition(error, expedition, expectation)
                    return
                }
            )
        }
        
        wait(for: [expectation], timeout: 5)
        return
        
    }
    
    func testUpdateExpedition() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestExpedition(expectation) { (created, session) in
            
            var components = DateComponents()
            components.day = 1
            guard let newDepartureTime = Calendar.current.date(
                byAdding: components,
                to: created.departureTime
            ) else { fatalError("date arithmetic fail")}
            
            created.update(
                checkinTime: created.checkinTime,
                checkinLocation: created.checkinLocation,
                departureTime: newDepartureTime,
                session: session,
                then: { (error, expedition) in
                    guard let expedition = expedition else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    
                    guard expedition.departureTime == newDepartureTime else {
                        XCTFail("""
                        Mismatched departure times.
                        Original: \(created.departureTime)
                        New: \(expedition.departureTime)
                        """)
                        expectation.fulfill()
                        return
                    }
                    
                    XCTAssertNil(error)
                    expectation.fulfill()
                    
                }
            )
        }
        
        wait(for: [expectation], timeout: 5)
        return
        
    }
    
    func testRetrieveManyExpeditions() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestExpedition(expectation) { (created, session) in
            
            Shop.retrieve(
                withPublicId: created.shopId,
                session: session) { (erro, shop) in
                guard let shop = shop else {
                    XCTFail(); expectation.fulfill(); return
                }
                Expedition.retrieveMany(
                    session: session,
                    byShop: shop,
                    then: { (error, shops) in
                        guard error == nil else {
                            XCTFail(); expectation.fulfill(); return
                        }
                        guard let shops = shops else {
                            XCTFail(); expectation.fulfill(); return
                        }
                        guard shops.count == 1 else {
                            XCTFail(); expectation.fulfill(); return
                        }
                        expectation.fulfill()
                        return
                    }
                )
            }
        }
        
        wait(for: [expectation], timeout: 5)
        return
    }
    
    func testCreateCrewmember() {
        
        let expectation = XCTestExpectation()
        
        func create(_ member: Teammember, _ exp: Expedition, _ ses: Session) {
            
            CrewMember.create(
                session: ses,
                teammember: member,
                expedition: exp,
                role: .captain,
                callback: { (error, crewmember) in
                    XCTAssertNil(error)
                    XCTAssertNotNil(crewmember)
                    expectation.fulfill()
                    return
                }
            )
            
        }
        
        TestUtility.createTestShop(expectation) { (shop, session) in

            let existing = TestUtility.ExistingTestShop(
                shop: shop,
                session: session
            )

            TestUtility.createTestTeammember(
                expectation,
                existing,
                then: { member, session in
                    
                    TestUtility.createTestExpedition(
                        expectation,
                        existing,
                        then: { (expedition, session) in
                            
                            create(member, expedition, session)
                            return
                    
                        }
                    )
                    
                }
            )
            
            return

        }
        
        wait(for: [expectation], timeout: 5)
        
        return

    }
    
    func testRetrieveCrewmemberList() {
        
        let expectation = XCTestExpectation()
        
        func retrieve(
            _ member: CrewMember,
            _ session: Session
        ) {
            
            Expedition.retrieve(
                withPublicId: member.expeditionId,
                session: session,
                then: { (error, expedition) in
    
                    guard let expedition = expedition else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    
                    CrewMember.retrieveMany(
                        session: session,
                        expedition: expedition,
                        then: { (error, crewmembers) in
                            guard let crewmembers = crewmembers else {
                                XCTFail(); expectation.fulfill(); return
                            }
                            XCTAssert(crewmembers.count > 0)
                            expectation.fulfill()
                            return
                        }
                    )
                    
                    return
            
                }
            )
            
            return
            
        }
        
        TestUtility.createTestCrewmember(
            expectation,
            then: { (member, session) in
                retrieve(member, session)
                return
            }
        )
        
        wait(for: [expectation], timeout: 5)
        
        return

    }
    
    func testUpdateCrewmember() {
        
        let expectation = XCTestExpectation()
        
        func update(_ member: CrewMember, _ session: Session) {
            
            let targetState = !member.active
            
            member.update(
                session: session,
                active: targetState,
                role: .crew,
                then: { (error, member) in
                    XCTAssertNil(error)
                    guard let member = member else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    XCTAssert(member.active == targetState)
                    expectation.fulfill()
                    return
                }
            )
            
            return

        }
        
        TestUtility.createTestCrewmember(expectation) { (member, session) in
            update(member, session)
            return
        }
        
        wait(for: [expectation], timeout: 5)
        
        return

    }
    
    func testCreateLeg() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestExpedition(
            expectation
        ) { (expedition, session) in
            
            Leg.create(
                session: session,
                expedition: expedition,
                sequence: 1
            ) { (error, leg) in
                XCTAssertNil(error)
                XCTAssertNotNil(leg)
                expectation.fulfill()
                return
            }
            
        }
        
        wait(for: [expectation], timeout: 5)
        
        return
        
    }
    
    func testUpdateLeg() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestLeg(expectation) { (leg, session) in
            leg.update(
                session: session,
                sequence: 1,
                active: false,
                then: { (error, leg) in
                    guard error == nil else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    guard leg != nil else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    expectation.fulfill()
                    return
                }
            )
        }
        
        wait(for: [expectation], timeout: 5)
        
        return
        
    }
    
    func testRetrieveManyLegs() {
        
        let expectation = XCTestExpectation()
        
        func receiveExpedition(
            session: Session,
            error: Error?,
            expedition: Expedition?
        ) {
            
            guard let expedition = expedition else {
                expectation.fulfill(); XCTFail(); return
            }
            
            Leg.retrieveMany(
                session: session,
                expedition: expedition
            ) { (error, legs) in
                
                guard let legs = legs else {
                    expectation.fulfill(); XCTFail(); return
                }
                
                guard legs.count > 0 else {
                    expectation.fulfill(); XCTFail(); return
                }
                
                expectation.fulfill()
                return
    
            }
            
            return
            
        }
        
        
        TestUtility.createTestLeg(expectation) { (leg, session) in
            
            Expedition.retrieve(
                withPublicId: leg.expeditionId,
                session: session) { (error, expedition) in
                
                receiveExpedition(
                    session: session,
                    error: error,
                    expedition: expedition
                )
                
                return

            }
        }
        
        wait(for: [expectation], timeout: 5)
        
        return
        
    }
    
    func testCreateParticipant() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestLeg(expectation) { (leg, session) in
            
            TestUtility.createTestHuman(expectation) { (human) in

                Participant.create(
                    session: session,
                    leg: leg,
                    human: human,
                    activities: [.dive]) { (error, participant) in
                    
                    guard error == nil else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    
                    guard participant != nil else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    
                    expectation.fulfill()
                    return
                    
                }
                
                return
                
            }
            
            return

        }
        
        wait(for: [expectation], timeout: 5)
        
        return
        
    }
    
    func testRetrieveManyParticipants() {
        
        let expectation = XCTestExpectation()
        
        func tryRetrieval(_ leg: Leg, _ session: Session) {
            Participant.retrieveMany(
                session: session,
                leg: leg
            ) { (error, participants) in
                XCTAssertNil(error)
                guard let participants = participants else {
                    XCTFail(); expectation.fulfill(); return
                }
                guard participants.count > 1 else {
                    XCTFail(); expectation.fulfill(); return
                }
                expectation.fulfill()
                return
            }
        }
        
        TestUtility.createTestLeg(expectation) { (leg, session) in
            
            let existing = TestUtility.ExistingLeg(session: session, leg: leg)
            
            TestUtility.createTestHuman(expectation) { (human1) in
                TestUtility.createTestHuman(expectation) { (human2) in
                    TestUtility.createTestParticipant(
                        expectation,
                        existingLeg: existing,
                        human: human1
                    ) { (participant, session) in
                        TestUtility.createTestParticipant(
                            expectation,
                            existingLeg: existing,
                            human: human2
                        ) { (participant2, session) in
                            tryRetrieval(leg, session)
                        }
                    }
                }
            }
        }
        
        wait(for: [expectation], timeout: 5)
        
    }

}
