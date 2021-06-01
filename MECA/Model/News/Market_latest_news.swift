/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Market_latest_news : Codable {
	let id : Int?
	let title : String?
	let category : String?
	let cover_image : String?
	let created_at : String?
	let writer_name : String?
	let plain_description : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case category = "category"
		case cover_image = "cover_image"
		case created_at = "created_at"
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
		writer_name = try values.decodeIfPresent(String.self, forKey: .writer_name)
		plain_description = try values.decodeIfPresent(String.self, forKey: .plain_description)
	}

}