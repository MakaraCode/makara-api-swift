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
            then: { (error, human, session) in
                guard let session = session else {
                    XCTFail("no session")
                    expectation.fulfill()
                    return
                }
                
                Shop.create(
                    name: "Swift Test Shop",
                    session: session,
                    location: Location(
                        coordinates: Coordinates(
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
}
