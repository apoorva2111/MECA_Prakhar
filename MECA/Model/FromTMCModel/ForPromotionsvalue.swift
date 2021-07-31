//
//  ForPromotionsvalue.swift
//  MECA
//
//  Created by Macbook  on 06/07/21.
//

import Foundation
struct ForPromotionsvalue :Codable {
    let title : String?
    let video_link : String?
    let content : String?
    let link_to_open : String?
    enum CodingKeys: String, CodingKey {
        
         case title = "title"
         case video_link = "video_link"
         case content = "content"
         case link_to_open = "link_to_open"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        video_link = try values.decodeIfPresent(String.self, forKey: .video_link)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        link_to_open = try values.decodeIfPresent(String.self, forKey: .link_to_open)
        
    }
}
