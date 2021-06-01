

import Foundation
struct News_MEBITCat : Codable {
	let category : String?
	let subcategories : [String]?

	enum CodingKeys: String, CodingKey {

		case category = "category"
		case subcategories = "subcategories"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		subcategories = try values.decodeIfPresent([String].self, forKey: .subcategories)
	}

}
