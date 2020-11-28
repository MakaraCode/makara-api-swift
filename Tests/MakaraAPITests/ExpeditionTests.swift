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
}
