

import Foundation
struct NewsData : Codable {
	let ourpicks : [Ourpicks]?
	let market_latest_news : [Market_latest_news]?
	let toyota_latest_news : [Toyota_latest_news]?
	let videos : [Videos_News]?

	enum CodingKeys: String, CodingKey {

		case ourpicks = "ourpicks"
		case market_latest_news = "market_latest_news"
		case toyota_latest_news = "toyota_latest_news"
		case videos = "videos"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		ourpicks = try values.decodeIfPresent([Ourpicks].self, forKey: .ourpicks)
		market_latest_news = try values.decodeIfPresent([Market_latest_news].self, forKey: .market_latest_news)
		toyota_latest_news = try values.decodeIfPresent([Toyota_latest_news].self, forKey: .toyota_latest_news)
		videos = try values.decodeIfPresent([Videos_News].self, forKey: .videos)
	}

}
