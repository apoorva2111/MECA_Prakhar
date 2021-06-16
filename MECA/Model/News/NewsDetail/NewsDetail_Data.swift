
import Foundation
struct NewsDetail_Data : Codable {
	let id : Int?
	let title : String?
	let category : String?
	let subcategory : String?
	let content : String?
	let cover_image : String?
	let documents : [Document_News]?
	let tags : [String]?
	let user : Int?
	let is_admin : Int?
	let is_dummy : Int?
	let created_at : String?
	let updated_at : String?
	let plain_description : String?
	let related : [Related]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case category = "category"
		case subcategory = "subcategory"
		case content = "content"
		case cover_image = "cover_image"
		case documents = "documents"
		case tags = "tags"
		case user = "user"
		case is_admin = "is_admin"
		case is_dummy = "is_dummy"
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
		subcategory = try values.decodeIfPresent(String.self, forKey: .subcategory)
		content = try values.decodeIfPresent(String.self, forKey: .content)
		cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
		documents = try values.decodeIfPresent([Document_News].self, forKey: .documents)
		tags = try values.decodeIfPresent([String].self, forKey: .tags)
		user = try values.decodeIfPresent(Int.self, forKey: .user)
		is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
		is_dummy = try values.decodeIfPresent(Int.self, forKey: .is_dummy)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		plain_description = try values.decodeIfPresent(String.self, forKey: .plain_description)
		related = try values.decodeIfPresent([Related].self, forKey: .related)
	}

}
