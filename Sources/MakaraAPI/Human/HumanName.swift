//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 21/8/20.
//

import Foundation


public struct HumanNameComponent: Codable, Comparable, CustomStringConvertible {
    public let sequence: Int
    public let content: String
    
    public var description: String { get {
        return self.content
    } }
    
    public init(_ sequence: Int, _ content: String) {
        self.sequence = sequence
        self.content = content
    }
    
    public static func < (
        lhs: HumanNameComponent,
        rhs: HumanNameComponent
    ) -> Bool {
        if (lhs.sequence < rhs.sequence) { return true }
        return false
    }
    
    public static func == (
        lhs: HumanNameComponent,
        rhs: HumanNameComponent
    ) -> Bool {
        if (lhs.sequence == rhs.sequence) { return true }
        return false
    }

}


public struct HumanName: Codable, CustomStringConvertible {

    public let components: Array<HumanNameComponent>
    public var whole: String { get {
        return components.sorted().map { (h) -> String in
            return h.content
        }.joined(separator: " ")
    } }
    
    public var description: String { get {
        return self.whole
    } }
    
    public init (_ components: Array<HumanNameComponent>) {
        self.components = components
    }
}
