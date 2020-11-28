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
    
    public var name: String { get {
        return self.pointOfInterest.name
    } }
    
    public var location: Location { get {
        return self.pointOfInterest.location
    } }
    
    public var coverImage: Image? { get {
        return self.pointOfInterest.coverImage
    } }
    
    public var profileImage: Image? { get {
        return self.pointOfInterest.profileImage
    } }
    
    public var referenceFrame: SpatialReferenceFrame? { get {
        return self.pointOfInterest.referenceFrame
    } }

}
