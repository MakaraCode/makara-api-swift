//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 25/8/20.
//

import Foundation


internal struct QueuedAction: Identifiable {

    let sequence: Int
    /*let model: Model*/
    let action: Action
    
    internal var id: Int { get { return self.sequence } }
    
    
}
