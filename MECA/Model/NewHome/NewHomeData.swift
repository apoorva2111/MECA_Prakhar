

import Foundation
struct NewHomeData : Codable {
    let avatar : String?
    let comments_count : Int?
    let content : String?
    let cover_image : String?
    let created_at : String?
    let document_link : String?
    let id : Int?
    let images : [String]?
    let isLiked : Int?
    let isOwner : Int?
    let is_admin : Int?
    let likes : Int?
    let type : Int?
    let updated_at : String?
    let user : Int?
    let video_link : String?
    let writer_name : String?

    enum CodingKeys: String, CodingKey {

        case avatar = "avatar"
        case comments_count = "comments_count"
        case content = "content"
        case cover_image = "cover_image"
        case created_at = "created_at"
        case document_link = "document_link"
        case id = "id"
        case images = "images"
        case isLiked = "isLiked"
        case isOwner = "isOwner"
        case is_admin = "is_admin"
        case likes = "likes"
        case type = "type"
        case updated_at = "updated_at"
        case user = "user"
        case video_link = "video_link"
        case writer_name = "writer_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        comments_count = try values.decodeIfPresent(Int.self, forKey: .comments_count)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        document_link = try values.decodeIfPresent(String.self, forKey: .document_link)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        isLiked = try values.decodeIfPresent(Int.self, forKey: .isLiked)
        isOwner = try values.decodeIfPresent(Int.self, forKey: .isOwner)
        is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        user = try values.decodeIfPresent(Int.self, forKey: .user)
        video_link = try values.decodeIfPresent(String.self, forKey: .video_link)
        writer_name = try values.decodeIfPresent(String.self, forKey: .writer_name)
    }

}
