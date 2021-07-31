

import Foundation
struct NotificationList_Data : Codable {
	let id : Int?
	let user_type : Int?
	let module : Int?
	let item : Int?
	let user : Int?
	let message : String?
	let status : Int?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user_type = "user_type"
		case module = "module"
		case item = "item"
		case user = "user"
		case message = "message"
		case status = "status"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		user_type = try values.decodeIfPresent(Int.self, forKey: .user_type)
		module = try values.decodeIfPresent(Int.self, forKey: .module)
		item = try values.decodeIfPresent(Int.self, forKey: .item)
		user = try values.decodeIfPresent(Int.self, forKey: .user)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
