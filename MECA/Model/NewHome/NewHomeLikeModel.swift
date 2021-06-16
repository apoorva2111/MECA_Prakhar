
import Foundation
struct NewHomeLikeModel : Codable {
	let data : NewHomeData?
	let message : String?
	let resp_code : Int?

	enum CodingKeys: String, CodingKey {

		case data = "data"
		case message = "message"
		case resp_code = "resp_code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent(NewHomeData.self, forKey: .data)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		resp_code = try values.decodeIfPresent(Int.self, forKey: .resp_code)
	}

}
