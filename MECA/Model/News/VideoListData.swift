
import Foundation
struct VideoListData : Codable {
	let title : String?
	let videos : [Videos_News]?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case videos = "videos"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		videos = try values.decodeIfPresent([Videos_News].self, forKey: .videos)
	}

}
