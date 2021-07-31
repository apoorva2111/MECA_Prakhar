/* 


*/

import Foundation
struct DatafromTMC : Codable {
	let promotion : Promotion?
	let tmcs : [Tmcs]?

	enum CodingKeys: String, CodingKey {

		case promotion = "promotion"
		case tmcs = "tmcs"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		promotion = try values.decodeIfPresent(Promotion.self, forKey: .promotion)
		tmcs = try values.decodeIfPresent([Tmcs].self, forKey: .tmcs)
	}

}
