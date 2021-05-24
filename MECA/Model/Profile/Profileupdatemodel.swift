//
//  Profileupdate.swift
//  MECA
//
//  Created by Macbook  on 17/05/21.
//

import Foundation
struct Profileupdatemodel:  Codable {
    let message :String?
    let resp_code : Int?
    let data : LoginUserModel?
    enum CodingKeys: String, CodingKey {

        case message = "message"
        case resp_code = "resp_code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        resp_code = try values.decodeIfPresent(Int.self, forKey: .resp_code)
        data = try values.decodeIfPresent(LoginUserModel.self, forKey: .data)
    }

}
