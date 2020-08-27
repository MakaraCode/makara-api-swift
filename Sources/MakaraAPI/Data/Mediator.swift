//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 25/8/20.
//

import Foundation


class Mediator {
    /* The purpose of Mediator is to buffer requests to the Makara API, such
     that Makara applications can continue to function during interruptions to
     their network connections.*/
    
    private var queue: Array<QueuedAction>
    
    init() { queue = Array() }
    
    /*public func enqueue(
        model: Model,
        action: Action
    ) {
        
        queue.append(QueuedAction(
            sequence: 1, model: model, action: action
        ))
        
        return
    
    }
    */
    
    
    
}
