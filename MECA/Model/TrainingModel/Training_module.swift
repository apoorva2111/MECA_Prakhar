//
//  Training_module.swift
//  MECA
//
//  Created by Macbook  on 30/05/21.
//

import Foundation
struct Training_module : Codable {
    let id : String?
    let lable : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case lable = "lable"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        lable = try values.decodeIfPresent(String.self, forKey: .lable)
    }

}
