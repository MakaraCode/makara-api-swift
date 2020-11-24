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
        email: String,
        then callback: @escaping (Error?, Human?) -> Void
    ) {
        
        Human.create(
            name: HumanName([
                HumanNameComponent(1, "Barack"),
                HumanNameComponent(2, "Obama")
            ]),
            email: email,
            secret: Self.testHumanSecret,
            session: nil,
            then: callback
        )
        
    }
    
    internal static func createTestSession(
        then callback: @escaping (Error?, Human?, Session?) -> Void
    ) {
        
        let email = Self.createTestEmail()
        
        createTestHuman(email: email, then: { (error, human) in
            guard error == nil else { callback(error, nil, nil); return }
            guard let human = human else {
                callback(MakaraAPIError(.testError), nil, nil)
                return
            }
            Session.create(
                email: email,
                secret: Self.testHumanSecret,
                then: { (error, session) in
                    callback(error, human, session)
                    return
                }
            )
            return
        })
        
    }
    
    internal static func createTestShop(
        then callback: @escaping (Error?, Shop?, Session?) -> Void
    ) {
        
        Self.createTestSession { (error, human, session) in
            guard let session = session else {
                callback(error ?? MakaraAPIError(.testError), nil, nil)
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
                    callback(error, shop, session)
                    return
                }
            )
            
            return
        }
        
        return
        
    }
    
}
