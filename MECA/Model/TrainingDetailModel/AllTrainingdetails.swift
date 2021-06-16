//
//  AllTrainingdetails.swift
//  MECA
//
//  Created by Macbook  on 30/05/21.
//

import Foundation
// MARK: - DataClass
struct AllTrainingdetails : Codable {
    let data : Detailsinfo?
   
    let resp_code : Int?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case message = "message"
        case resp_code = "resp_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(Detailsinfo.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        resp_code = try values.decodeIfPresent(Int.self, forKey: .resp_code)
    }

}
