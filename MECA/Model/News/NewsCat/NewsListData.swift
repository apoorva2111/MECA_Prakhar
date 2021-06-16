

import Foundation
struct NewsListData : Codable {
	let id : Int?
	let title : String?
	let category : String?
	let cover_image : String?
	let created_at : String?
	let tags : [String]?
	let writer_name : String?
	let plain_description : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case category = "category"
		case cover_image = "cover_image"
		case created_at = "created_at"
		case tags = "tags"
		case writer_name = "writer_name"
		case plain_description = "plain_description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		tags = try values.decodeIfPresent([String].self, forKey: .tags)
		writer_name = try values.decodeIfPresent(String.self, forKey: .writer_name)
		plain_description = try values.decodeIfPresent(String.self, forKey: .plain_description)
	}

}
