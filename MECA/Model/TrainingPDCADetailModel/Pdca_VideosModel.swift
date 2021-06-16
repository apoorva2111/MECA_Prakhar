//
//  Pdca_VideosModel.swift
//  MECA
//
//  Created by Macbook  on 04/06/21.
//

import Foundation
// MARK: - Welcome
struct Pdca_VideosModel: Codable {
    let id, pdca, session: Int?
    let title, info: String?
    let videoLink: String?
    let type: Int?
    let createdAt, updatedAt: String?
    let isViewed: Int?

    enum CodingKeys: String, CodingKey {
        case id, pdca, session, title, info
        case videoLink = "video_link"
        case type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isViewed = "is_viewed"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        
        pdca = try values.decodeIfPresent(Int.self, forKey: .pdca)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        info = try values.decodeIfPresent(String.self, forKey: .info)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        session = try values.decodeIfPresent(Int.self, forKey: .session)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        isViewed = try values.decodeIfPresent(Int.self, forKey: .isViewed)
        
        videoLink = try values.decodeIfPresent(String.self, forKey: .videoLink)
       
       
    }

}
