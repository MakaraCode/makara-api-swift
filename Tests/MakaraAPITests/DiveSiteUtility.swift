//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 17/1/21.
//

import XCTest
@testable import MakaraAPI


struct DiveSiteUtility {
    
    internal static func createTestSite(
        _ expectation: XCTestExpectation,
        _ session: Session? = nil,
        then callback: @escaping (DiveSite, Session) -> Void
    ) {
        
        func stageSession(_ session: Session) {
            
            DiveSite.create(
                session: session,
                name: "Test Site",
                description: nil,
                location: Location(
                    Coordinates(longitude: 151.2153, latitude: 33.8568),
                    altitude: 0.0
                )
            ) { (error, site) in
                
                guard let site = site else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                callback(site, session)
                
                return

            }
            
        }
        
        if let session = session {
            stageSession(session)
            return
        }
        
        TestUtility.createTestSession(expectation) { (human, session) in
            stageSession(session)
        }
        
        return
        
    }
    
    internal static func createTestSiteProfile(
        _ expectation: XCTestExpectation,
        _ session: Session? = nil,
        _ site: DiveSite? = nil,
        _ shop: Shop? = nil,
        then callback: @escaping (DiveSiteProfile, Session) -> Void
    ) {
        
        func stageShop(
            _ shop: Shop,
            _ session: Session,
            _ site: DiveSite
        ) {
            
            DiveSiteProfile.create(
                session: session,
                shop: shop,
                site: site,
                name: "Test Site",
                description: "Created in Swift test suite",
                offered: true
            ) { (error, profile) in
                
                guard let profile = profile else {
                    XCTFail(); expectation.fulfill(); return
                }
                
                callback(profile, session)

                return
                
            }
            
        }
        
        func stageSite(
            _ site: DiveSite,
            _ session: Session
        ) {
            
            if let shop = shop {
                stageShop(shop, session, site)
                return
            }
            
            TestUtility.createTestShop(
                expectation,
                session
            ) { (shop, session) in
                stageShop(shop, session, site)
                return
            }
            
            return
            
        }
        
        func stageSession(
            _ session: Session
        ) {
            
            if let site = site {
                stageSite(site, session)
                return
            }
            
            DiveSiteUtility.createTestSite(
                expectation,
                session
            ) { (site, session) in
                stageSite(site, session)
                return
            }
            
            return
    
        }
        
        if let session = session {
            stageSession(session)
            return
        }
        
        TestUtility.createTestSession(
            expectation
        ) { (human, session) in
            
            stageSession(session)
            return
            
        }
        
        return

    }
    
}
