/* 


*/

import Foundation
struct Tmcs : Codable {
	let id : Int?
	let title : String?
	let type : String?
	let link_type : String?
	let cover_image : String?
	let doc_link : String?
	let status : Int?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case type = "type"
		case link_type = "link_type"
		case cover_image = "cover_image"
		case doc_link = "doc_link"
		case status = "status"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		link_type = try values.decodeIfPresent(String.self, forKey: .link_type)
		cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
		doc_link = try values.decodeIfPresent(String.self, forKey: .doc_link)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
