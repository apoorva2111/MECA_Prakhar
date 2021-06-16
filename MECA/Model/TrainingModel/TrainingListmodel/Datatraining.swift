//
//  Datatraining.swift
//  MECA
//
//  Created by Macbook  on 30/05/21.
//

import Foundation

// MARK: - DataClass
struct Datatraining : Codable {
    let data : [Trainingdatalist]?
    let total : Int?
    let resp_code : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case total = "total"
        case resp_code = "resp_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Trainingdatalist].self, forKey: .data)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        resp_code = try values.decodeIfPresent(Int.self, forKey: .resp_code)
    }

}
