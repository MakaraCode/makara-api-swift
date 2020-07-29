//
//  Image.swift
//  
//
//  Created by Hugh Jeremy on 30/7/20.
//

import Foundation


public struct Image: Media {
    
    public let mediaType = MediaType.image

    public let publicId: String
    public let mediaQuality: MediaQuality
    public let mediaCodec: MediaCodec
    public let url: String
    public let dimensions: Array<MediaDimension>
    public let name: String?
    public let description: String?
    public let tags: Array<Tag>

    internal init(
        publicId: String,
        mediaQuality: MediaQuality,
        mediaCodec: MediaCodec,
        url: String,
        dimensions: Array<MediaDimension>,
        name: String?,
        description: String?,
        tags: Array<Tag>
    ) {
       
        self.publicId = publicId
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
        case mediaQuality = "media_quality"
        case mediaCodec = "media_codec"
        case url = "url"
        case dimensions = "dimensions"
        case description = "description"
        case name = "name"
        case tags = "tags"
        
    }
    
}
