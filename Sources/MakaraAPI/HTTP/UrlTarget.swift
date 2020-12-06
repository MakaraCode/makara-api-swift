//
//  File 2.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


internal struct UrlTarget {

    internal let key: String
    internal let value: String

    init(_ value: String, key: String) {
        self.key = key
        self.value = value
        return
    }
    
    init(_ value: Int, key: String) {
        self.key = key
        self.value = String(value)
        return
    }

    init(_ value: Bool, key: String) {
        
        self.key = key
        switch value {
        case true:
            self.value = "true"
        case false:
            self.value = "false"
        }
        return
    }
    
    internal static func createSequence(
        key: String,
        values: [String]
    ) -> [UrlTarget] {
        let targets = values.map {UrlTarget($0, key: key)}
        return targets
    }
    
    internal static func createSequence(
        key: String,
        values: [Int]
        ) -> [UrlTarget] {
        let targets = values.map {UrlTarget($0, key: key)}
        return targets
    }

}

extension UrlTarget: CustomStringConvertible {

    var description: String {
        return self.key + "=" + self.value
    }
}

extension UrlTarget: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(value)
    }
    
    static func == (lhs: UrlTarget, rhs: UrlTarget) -> Bool {
        return lhs.key == rhs.key && lhs.value == rhs.value
    }
}
