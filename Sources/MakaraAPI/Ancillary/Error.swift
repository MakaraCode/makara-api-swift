//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public protocol MakaraError: Identifiable, Error, CustomStringConvertible {
    
    var message: String { get }
    var technicalMessage: String? { get }
    
}

extension MakaraError {
    
    public var description: String { get { return self.message } }
    public var technicalMessage: String? { get { return nil } }
    
}
