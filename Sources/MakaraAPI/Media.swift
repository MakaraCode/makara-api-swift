//
//  File 2.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


public class Media: Codable {
    
    let publicId: String
    let mediaType: MediaType
    let mediaQuality: MediaQuality
    let mediaCodec: MediaCodec
    let url: String
    let dimensions: Array<MediaDimension>
    let name: String?
    let description: String?
    let tags: Array<Tag>
    
    internal init(
        publicId: String,
        mediaType: MediaType,
        mediaQuality: MediaQuality,
        mediaCodec: MediaCodec,
        url: String,
        dimensions: Array<MediaDimension>,
        name: String?,
        description: String?,
        tags: Array<Tag>
    ) {
       
        self.publicId = publicId
        self.mediaType = mediaType
        self.mediaQuality = mediaQuality
        self.mediaCodec = mediaCodec
        self.url = url
        self.dimensions = dimensions
        self.name = name
        self.description = description
        self.tags = tags
        
        return
    }
    
    enum CodingKeys: String, CodingKey {
        
        case publicId = "public_id"
        case mediaType = "media_type"
        case mediaQuality = "media_quality"
        case mediaCodec = "media_codec"
        case url = "url"
        case dimensions = "dimensions"
        case description = "description"
        case name = "name"
        case tags = "tags"
        
    }
    
}
