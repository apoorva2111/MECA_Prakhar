//
//  AllvaluesSpecialsite.swift
//  MECA
//
//  Created by Macbook  on 20/07/21.
//

import Foundation

struct AllvaluesSpecialsite : Codable {
    let data : SpecialsiteData?
    let resp_code : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case resp_code = "resp_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(SpecialsiteData.self, forKey: .data)
        resp_code = try values.decodeIfPresent(Int.self, forKey: .resp_code)
    }

}
