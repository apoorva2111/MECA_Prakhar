//
//  Wall_of_fameListModel.swift
//  MECA
//
//  Created by Macbook  on 03/06/21.
//

import Foundation

// MARK: - DataClass
struct Wall_of_fameListModel : Codable {
    let data : [walloffame_datas]?
    let total : Int?
    let resp_code : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case total = "total"
        case resp_code = "resp_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([walloffame_datas].self, forKey: .data)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        resp_code = try values.decodeIfPresent(Int.self, forKey: .resp_code)
    }

}
