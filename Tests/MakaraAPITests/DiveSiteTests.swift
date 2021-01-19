//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 17/1/21.
//

import XCTest
@testable import MakaraAPI

final class MakaraAPI_DiveSiteTests: XCTestCase {
    
    func testCreateDiveSite() {
        
        let expectation = XCTestExpectation()
        
        TestUtility.createTestSession(expectation) { (human, session) in
    
            DiveSite.create(
                session: session,
                name: "Test Site",
                description: nil,
                location: Location(
                    Coordinates(longitude: 151.2153, latitude: 33.8568),
                    altitude: 0.0
                )
            ) { (error, site) in
                
                guard error == nil else {
                    XCTFail(); expectation.fulfill(); return
                }
    
                XCTAssertNotNil(site)
                expectation.fulfill()
                return
            }
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
    func testRetrieveDiveSite() {
        
        let expectation = XCTestExpectation()
        
        DiveSiteUtility.createTestSite(expectation) { (site, session) in
            
            DiveSite.retrieve(
                withPublicId: site.publicId,
                session: session
            ) { (error, retrievedSite) in
                
                guard error == nil else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                XCTAssertNil(error)
                XCTAssertNotNil(retrievedSite)
                expectation.fulfill()
                
                return
                
            }
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
    func testUpdateDiveSite() {
        
        let expectation = XCTestExpectation()
        let newName = "testUpdateDiveSite Name"
        
        DiveSiteUtility.createTestSite(expectation) { (site, session) in
            
            site.update(
                session: session,
                name: newName
            ) { (error, site) in
                
                XCTAssertNil(error)
                
                guard let site = site else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                guard site.name == newName else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                expectation.fulfill()
                return
            }
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
    func testListDiveSites() {
        
        let expectation = XCTestExpectation()
        
        DiveSiteUtility.createTestSite(expectation) { (site, session) in
            
            DiveSite.retrieveMany(
                session: session
            ) { (error, sites) in
                
                XCTAssertNil(error)
                
                guard let sites = sites else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                guard sites.count > 0 else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                expectation.fulfill()
                
                return
                
            }
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }
    
    func testCreateSiteProfile() {
        
        let expectation = XCTestExpectation()
        
        DiveSiteUtility.createTestSite(expectation) { (site, session) in
            
            TestUtility.createTestShop(
                expectation,
                session
            ) { (shop, session) in
                
                DiveSiteProfile.create(
                    session: session,
                    shop: shop,
                    site: site
                ) { (error, profile) in
                    
                    XCTAssertNil(error)
                    XCTAssertNotNil(profile)
                    expectation.fulfill()
                    return

                }
                
                return

            }
            
            return

        }
        
        wait(for: [expectation], timeout: 5.0)

        return

    }
    
    func testRetrieveSiteProfile() {
        
        let expectation = XCTestExpectation()
        
        func stage(
            _ site: DiveSite,
            _ shop: Shop,
            _ session: Session
        ) -> Void {
            
            DiveSiteProfile.retrieve(
                session: session,
                site: site,
                shop: shop
            ) { (error, profile) in
                
                guard profile != nil else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                expectation.fulfill()
                
                return

            }

        }
        
        DiveSiteUtility.createTestSiteProfile(
            expectation
        ) { (profile, session) in
            
            Shop.retrieve(
                withPublicId: profile.shopId,
                session: session
            ) { (error, shop) in
                
                guard let shop = shop else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                stage(profile.site, shop, session)
                
                return

            }

        }
        
        wait(for: [expectation], timeout: 5.0)

        return

    }
    
    func testListSiteProfiles() {
        
        let expectation = XCTestExpectation()
        
        func afterCreation(_ session: Session, _ shop: Shop) {
            
            DiveSiteProfile.retrieveMany(
                session: session,
                shop: shop
            ) { (error, sites) in
                
                XCTAssertNil(error)
                guard let sites = sites else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                guard sites.count == 2 else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                expectation.fulfill()

                return

            }

            return
            
        }
        
        DiveSiteUtility.createTestSiteProfile(
            expectation
        ) { (profile, session) in
            
            Shop.retrieve(
                withPublicId: profile.shopId,
                session: session
            ) { (error, shop) in
                
                guard let shop = shop else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                DiveSiteUtility.createTestSiteProfile(
                    expectation,
                    session,
                    nil,
                    shop
                ) { (profile, session) in
                    
                    afterCreation(session, shop)
                    return
                    
                }

                return

            }
            
            return

        }

        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
    
}
