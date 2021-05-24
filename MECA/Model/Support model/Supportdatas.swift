//
//  Supportdatas.swift
//  MECA
//
//  Created by Macbook  on 21/05/21.
//

import Foundation

struct Supportdatas: Codable {
    
    let category : String?
    let incharge : String?
    let email : String?
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case category = "category"
         case incharge = "incharge"
         case email = "email"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        incharge = try values.decodeIfPresent(String.self, forKey: .incharge)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }
}

