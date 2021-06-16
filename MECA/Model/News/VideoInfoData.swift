


import Foundation
struct VideoInfoData : Codable {
	let id : Int?
	let title : String?
	let category : String?
	let video_link : String?
	let video_type : Int?
	let content : String?
	let documents : [Document_News]?
	let cover_image : String?
	let tags : [String]?
	let user : Int?
	let is_admin : Int?
	let created_at : String?
	let updated_at : String?
	let plain_description : String?
	let related : [Related]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case category = "category"
		case video_link = "video_link"
		case video_type = "video_type"
		case content = "content"
		case documents = "documents"
		case cover_image = "cover_image"
		case tags = "tags"
		case user = "user"
		case is_admin = "is_admin"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case plain_description = "plain_description"
		case related = "related"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		video_link = try values.decodeIfPresent(String.self, forKey: .video_link)
		video_type = try values.decodeIfPresent(Int.self, forKey: .video_type)
		content = try values.decodeIfPresent(String.self, forKey: .content)
		documents = try values.decodeIfPresent([Document_News].self, forKey: .documents)
		cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
		tags = try values.decodeIfPresent([String].self, forKey: .tags)
		user = try values.decodeIfPresent(Int.self, forKey: .user)
		is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		plain_description = try values.decodeIfPresent(String.self, forKey: .plain_description)
		related = try values.decodeIfPresent([Related].self, forKey: .related)
	}

}
