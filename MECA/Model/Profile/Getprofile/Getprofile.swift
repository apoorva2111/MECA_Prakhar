//
//  File.swift
//  MECA
//
//  Created by Macbook  on 17/05/21.
//

import Foundation

struct Getprofile : Codable {
    let data : LoginUserModel?
    let resp_code : Int?
    let token : String?
    

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case resp_code = "resp_code"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(LoginUserModel.self, forKey: .data)
        resp_code = try values.decodeIfPresent(Int.self, forKey: .resp_code)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }

}
