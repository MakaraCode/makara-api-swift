//
//  RandomNumber.swift
//  Makara
//
//  Created by Hugh Jeremy on 29/10/20.
//  Copyright © 2020 Blinky Beach. All rights reserved.
//

import Foundation


struct RandomNumber {
    
    let integer: Int
    
    init(withBitLength bitLength: Int = 63) {
        let maxSize = Int(pow(Double(2), Double(bitLength)))
        self.integer = Int.random(in: 0..<maxSize)
        return
    }
    
    var string: String { get {
        let utf8String = String(self.integer).data(using: .utf8)
        let base64 = utf8String!.base64EncodedString()
        return base64
                .replacingOccurrences(of: "+", with: "-")
                .replacingOccurrences(of: "/", with: "_")
                .replacingOccurrences(of: "=", with: "")
    } }
    
}
