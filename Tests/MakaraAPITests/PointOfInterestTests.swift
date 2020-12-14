//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 14/12/20.
//

import Foundation
import XCTest
@testable import MakaraAPI

final class MakaraAPI_PointOfInterestTests: XCTestCase {
    
    func testRetrievePointsOfInterest() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestShop(expectation) { (shop, session) in
            
            PointOfInterest.retrieveMany(
                session: session,
                relatedTo: shop,
                ofType: [.shop],
                then: { (error, points) in
                    
                    XCTAssertNil(error)
                    
                    guard let points = points else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    
                    guard points.count > 0 else {
                        XCTFail(); expectation.fulfill(); return
                    }
                    
                    expectation.fulfill();
                    return;
                    
                }
            )
            
        }
        
        wait(for: [expectation], timeout: 5)
        
        return
        
    }
    
}
