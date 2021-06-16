//
//  PDCAindexlist.swift
//  MECA
//
//  Created by Macbook  on 03/06/21.
//
/*
 
 "id": 3,
 "title": "PDCA for TSP Leaders & MASS Champion B2",
 "description": "Thank you For showing interest for Participating PDCA for TSP Leaders & MASS Champion B2 . \n\nThis Course content of 4 Days Recorded Lectures , kindly watch the series from Day 1 up to Day 4 . \non completing Each Day  Lecture Video, you will find a  download button to get the quiz. \nkindly after completing each day video Upload the answered quiz file using upload button.  \n\nFor any additional support please check with your program person in charge or contact MEBIT concierge  using the chat function .",
 "is_public": 1,
 "created_at": "2020-12-01 04:42:41",
 "updated_at": "2020-12-01 14:15:26"
}
 */
import Foundation
struct PDCAindexlist: Codable {
    let id: Int?
    let title:String?
    let description: String?
    let  is_public: Int?
    let created_at : String?
    let updated_at: String?
   
    
    enum CodingKeys: String , CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
         case is_public = "is_public"
         case created_at = "created_at"
         case updated_at  = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        is_public = try values.decodeIfPresent(Int.self, forKey: .is_public)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        
    }
    
    
    
    
}
