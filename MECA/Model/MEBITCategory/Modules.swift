

import Foundation
struct Modules : Codable {
	let id : Int?
	let module : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case module = "module"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		module = try values.decodeIfPresent(String.self, forKey: .module)
	}

}
