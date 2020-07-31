//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


internal struct QueryString: CustomStringConvertible {

    let targets: [UrlTarget]
    let paramString: String
    let entity: Entity?
    var description: String {
        return paramString
    }

    init(singleEntity entity: Entity) {
        self.entity = entity
        paramString = "?entity_id=" + entity.publicId
        targets = [UrlTarget]()
        return
    }

    init(entity: Entity, targets: [UrlTarget]) {
        self.entity = entity
        self.targets = targets
        var workingString = "?entity_id=" + entity.publicId
        for target in targets {
            workingString += "&" + String(describing: target)
        }
        paramString = workingString
        return
    }

    init(targetsOnly: [UrlTarget]) {
        
        entity = nil
        
        if targetsOnly.count < 1 {
            paramString = ""
            targets = [UrlTarget]()
            return
        }
        
        targets = targetsOnly
        var workingString = "?" + String(describing: targets[0])
        for target in targets.dropFirst() {
            workingString += "&" + String(describing: target)
        }
        paramString = workingString
        return
    }

    init(fromRawQuery query: String) {
        self.entity = nil
        paramString = query
        targets = [UrlTarget]()
        return
    }

}
