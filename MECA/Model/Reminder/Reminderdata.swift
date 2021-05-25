//
//  Reminderdata.swift
//  MECA
//
//  Created by Macbook  on 24/05/21.
//

import Foundation
struct Reminderdata:Codable {
    let item : Int?
    let status : Int?
    let due_date : String?
    let module : Int?
    let title : String?
    
    enum CodingKeys: String, CodingKey {
        case item = "item"
         case status = "status"
         case due_date = "due_date"
         case module = "id"
         case title = "title"
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        item = try values.decodeIfPresent(Int.self, forKey: .item)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        due_date = try values.decodeIfPresent(String.self, forKey: .due_date)
        module = try values.decodeIfPresent(Int.self, forKey: .module)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        
    }
}
