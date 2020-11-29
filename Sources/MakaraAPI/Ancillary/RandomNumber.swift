//
//  RandomNumber.swift
//  Makara
//
//  Created by Hugh Jeremy on 29/10/20.
//  Copyright © 2020 Blinky Beach. All rights reserved.
//

import Foundation


public struct RandomNumber {
    
    public let number: Decimal
    
    public init(_ size: RandomNumber.Size = .small) {
        self.number = Decimal(string: Self.build(size))!
        return
    }
    
    private static func build(_ size: Size) -> String {
        let base = Int.random(in: 0..<Int.max)
        if size == .small { return "\(base)" }
        let extra = Int.random(in: 0..<Int.max)
        return "\(base)\(extra)"
    }
    
    public var string: String { get {
        let utf8String = "\(self.number)".data(using: .utf8)
        let base64 = utf8String!.base64EncodedString()
        return base64
                .replacingOccurrences(of: "+", with: "-")
                .replacingOccurrences(of: "/", with: "_")
                .replacingOccurrences(of: "=", with: "")
    } }
    
    public enum Size {
        case small
        case large
    }
    
}
