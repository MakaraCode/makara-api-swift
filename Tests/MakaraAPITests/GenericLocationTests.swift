//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 31/1/21.
//

import Foundation
import XCTest
@testable import MakaraAPI

final class MakaraAPI_GenericLocationTests: XCTestCase {
    
    func testCreateGenericLocation() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestShop(expectation) { (shop, session) in
            
            GenericLocation.create(
                session: session,
                shop: shop,
                name: "Test Location",
                location: Location(
                    Coordinates(longitude: 120, latitude: 45)
                )
            ) { error, location in
                
                XCTAssertNil(error)
                
                guard location != nil else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                expectation.fulfill()
                return
            }
            
        }
        
        wait(for: [expectation], timeout: 5)
        
        return
        
    }
    
    func testRetrieveGenericLocation() {
        
        let expectation = XCTestExpectation()
        
        func receiveLocation(_ location: GenericLocation, _ session: Session) {
            
            GenericLocation.retrieve(
                withPublicId: location.publicId,
                session: session
            ) { error, retrieved in
                
                XCTAssertNil(error)
                
                guard retrieved != nil else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                expectation.fulfill()
                return
                
            }
            
        }
        
        TestUtility.createTestShop(expectation) { (shop, session) in
            
            GenericLocation.create(
                session: session,
                shop: shop,
                name: "Test Location",
                location: Location(
                    Coordinates(longitude: 120, latitude: 45)
                )
            ) { error, location in
                
                XCTAssertNil(error)
                
                guard let location = location else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                receiveLocation(location, session)
                return
                
            }
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }
    
    func testUpdateGenericLocation() {
        
        let expectation = XCTestExpectation()
        
        func receiveLocation(_ location: GenericLocation, _ session: Session) {
            
            location.update(
                session: session,
                active: false
            ) { (error, updated) in
                
                XCTAssertNil(error)
                XCTAssertNotNil(updated)
                expectation.fulfill()
                
                return
                
            }
            
        }
        
        TestUtility.createTestShop(expectation) { (shop, session) in
            
            GenericLocation.create(
                session: session,
                shop: shop,
                name: "Test Location",
                location: Location(
                    Coordinates(longitude: 120, latitude: 45)
                )
            ) { error, location in
                
                XCTAssertNil(error)
                
                guard let location = location else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                receiveLocation(location, session)
                return
                
            }
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }
    
}
