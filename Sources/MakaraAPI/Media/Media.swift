//
//  File 2.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation

public protocol Media: Codable {
    
    var publicId: String { get }
    var mediaType: MediaType { get }
    var mediaQuality: MediaQuality { get }
    var mediaCodec: MediaCodec { get }
    var url: String { get }
    var dimensions: Array<MediaDimension> { get }
    var name: String? { get }
    var description: String? { get }
    var tags: Array<Tag> { get }
    
}
