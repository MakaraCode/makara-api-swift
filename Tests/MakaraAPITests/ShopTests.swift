//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 13/11/20.
//

import XCTest
@testable import MakaraAPI

final class MakaraAPI_ShopTests: XCTestCase {
    
    static func receiveShop(
        _ error: Error?,
        _ shop: Shop?,
        _ expectation: XCTestExpectation
    ) {
        XCTAssertNil(error)
        XCTAssertNotNil(shop)
        expectation.fulfill()
        return
    }
    
    
    func testCreateShop() {
        
        let expectation = XCTestExpectation()
    
        TestUtility.createTestSession(
            expectation,
            then: { (human, session) in

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
                        Self.receiveShop(error, shop, expectation)
                        return
                })
            }
        )
        
        wait(for: [expectation], timeout: 5)
        return
    }

    func testRetrieveShop() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestShop(expectation) { (shop, session) in

            Shop.retrieve(
                withPublicId: shop.publicId,
                session: session
            ) { (error, shop) in
                Self.receiveShop(error, shop, expectation)
                return
            }

        }
        
        wait(for: [expectation], timeout: 5)
        return
    }
    
    func testRetrieveManyShops() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestShop(expectation) { (shop, session) in

            Shop.retrieveMany(
                session: session
            ) { (error, shops) in
                guard let shops = shops else {
                    XCTFail(); expectation.fulfill(); return
                }
                guard shops.count > 0 else {
                    XCTFail(); expectation.fulfill(); return
                }
                Self.receiveShop(error, shops[0], expectation)
                return
            }
        }
        
        wait(for: [expectation], timeout: 5)
        return
    }
    
    func testCreateTeammember() {
        
        let expectation = XCTestExpectation()
        
        func testCreation(_ human: Human, _ session: Session, _ shop: Shop) {
            
            Teammember.create(
                shop: shop,
                human: human,
                session: session,
                callback: { (error, teammember) in
                    XCTAssertNil(error)
                    XCTAssertNotNil(teammember)
                    expectation.fulfill()
                    return
                }
            )
            
        }
        
        TestUtility.createTestShop(expectation) { (shop, session) in
            
            TestUtility.createTestHuman(
                expectation,
                email: TestUtility.createTestEmail(),
                then: { (human) in
                    testCreation(human, session, shop)
                    return
                }
            )
            
        }
            
        wait(for: [expectation], timeout: 5)
        
        return

    }
    
    func testRetrieveTeammember() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestTeammember(expectation) { (member, session) in
            
            Teammember.retrieve(
                withPublicId: member.publicId,
                session: session,
                then: { error, teammember in
                    XCTAssertNil(error)
                    XCTAssertNotNil(teammember)
                    expectation.fulfill()
                    return
                }
            )
    
            return

        }
        
        wait(for: [expectation], timeout: 5)
        
        return
        
        
    }
    
    func testUpdateTeammember() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestTeammember(expectation) { (member, session) in
            
            XCTAssert(member.active == true)
            
            member.update(
                active: false,
                session: session,
                callback: { (error, teammember) in
                    guard let teammember = teammember else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    XCTAssertNil(error)
                    XCTAssert(teammember.active == false)
                    expectation.fulfill()
                    return
                }
            )
            
            return
        }
        
        wait(for: [expectation], timeout: 5)
        
        return
    }
    
    func testListTeammembers() {
        
        let expectation = XCTestExpectation()
        
        func list(_ shop: Shop, _ session: Session) {
            
            Teammember.retrieveMany(
                session: session,
                shop: shop,
                callback: { (error, members) in
                    XCTAssertNil(error)
                    guard let members = members else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    XCTAssert(members.count == 2)
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
                then: { (t1, session) in
                    TestUtility.createTestTeammember(
                        expectation,
                        existing,
                        then: { (t2, session) in
                            list(shop, session)
                            return
                        }
                    )
                    return
                }
            )
            
            return

        }
        
        wait(for: [expectation], timeout: 5)
        
        return
        
    }
}
