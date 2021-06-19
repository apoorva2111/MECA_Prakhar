

import Foundation
struct NewHomeSubComment : Codable {
    let id : Int?
    let feed : Int?
    let user : Int?
    let isfile : Int?
    let parent : Int?
    let likes : Int?
    let is_admin : Int?
    let is_reply : Int?
    let reply_for : Int?
    let comment : String?
    let created_at : String?
    let updated_at : String?
    let writer_name : String?
    let avatar : String?
   
  

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case feed = "feed"
        case isfile = "isfile"
        case user = "user"
        case parent = "parent"
        case likes = "likes"
        case is_admin = "is_admin"
        case is_reply = "is_reply"
        case reply_for = "reply_for"
        case comment = "comment"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case writer_name = "writer_name"
        case avatar = "avatar"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        feed = try values.decodeIfPresent(Int.self, forKey: .feed)
        isfile = try values.decodeIfPresent(Int.self, forKey: .isfile)
        parent = try values.decodeIfPresent(Int.self, forKey: .parent)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        is_reply = try values.decodeIfPresent(Int.self, forKey: .is_reply)
        reply_for = try values.decodeIfPresent(Int.self, forKey: .reply_for)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        writer_name = try values.decodeIfPresent(String.self, forKey: .writer_name)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        user = try values.decodeIfPresent(Int.self, forKey: .user)
        is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
    }

}
