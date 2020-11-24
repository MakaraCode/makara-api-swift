//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 24/11/20.
//

import Foundation


public protocol Located {
    
    var pointOfInterest: PointOfInterest { get }
    
}

extension Located {
    
    var name: String { get {
        return self.pointOfInterest.name
    } }
    
    var location: Location { get {
        return self.pointOfInterest.location
    } }
    
    var coverImage: Image? { get {
        return self.pointOfInterest.coverImage
    } }
    
    var profileImage: Image? { get {
        return self.pointOfInterest.profileImage
    } }
    
    var referenceFrame: SpatialReferenceFrame? { get {
        return self.pointOfInterest.referenceFrame
    } }

}
