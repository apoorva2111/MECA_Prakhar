//
//  calendardata.swift
//  MECA
//
//  Created by Macbook  on 23/05/21.
//

import Foundation

struct calendardata: Codable {
    
    let title : String?
    let type : Int?
    let start_date : String?
    let id : Int?
    let start_time : String?
    let  end_date : String?
    let end_time : String?
    
    
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
         case type = "type"
         case start_date = "start_date"
         case id = "id"
         case start_time = "start_time"
        case end_date = "end_date"
         case end_time = "end_time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
        end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
    }
}
