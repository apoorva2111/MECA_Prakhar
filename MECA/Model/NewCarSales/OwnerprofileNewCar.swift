/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct OwnerprofileNewCar : Codable {
	let id : Int?
	let email : String?
	let phone : String?
	let username : String?
	let status : Int?
	let reset_token : String?
	let avatar : String?
	let firebaseid : String?
	let role : Int?
	let firebasepassword : String?
	let last_call_at : Int?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case email = "email"
		case phone = "phone"
		case username = "username"
		case status = "status"
		case reset_token = "reset_token"
		case avatar = "avatar"
		case firebaseid = "firebaseid"
		case role = "role"
		case firebasepassword = "firebasepassword"
		case last_call_at = "last_call_at"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		username = try values.decodeIfPresent(String.self, forKey: .username)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		reset_token = try values.decodeIfPresent(String.self, forKey: .reset_token)
		avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
		firebaseid = try values.decodeIfPresent(String.self, forKey: .firebaseid)
		role = try values.decodeIfPresent(Int.self, forKey: .role)
		firebasepassword = try values.decodeIfPresent(String.self, forKey: .firebasepassword)
		last_call_at = try values.decodeIfPresent(Int.self, forKey: .last_call_at)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
