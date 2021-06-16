//
//  PdcaedetailModel.swift
//  MECA
//
//  Created by Macbook  on 04/06/21.
//

import Foundation
struct PdcaedetailModel : Codable {
    let created_at : String?
    
    let description : String?
    
    let id : Int?
    
    let has_access : Int?
    
    let is_public : Int?
    
   
    
    let title : String?
    
    
    let updated_at : String?
    
    
    let sessions : [sessionFilemodel]?
  //  let sessionsnew : sessionFilemodel?
    
    
    
    
     enum CodingKeys: String, CodingKey {
        
        case created_at = "created_at"
        case description = "description"
        case id = "id"
        
        case is_public = "is_public"
       
       case title = "title"
        case updated_at = "updated_at"
         case has_access = "has_access"
        
        
        case sessions = "sessions"
       // case sessionsnew = "sessions"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        
       
        is_public = try values.decodeIfPresent(Int.self, forKey: .is_public)
        
        description = try values.decodeIfPresent(String.self, forKey: .description)
       
       
        
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        
        has_access = try values.decodeIfPresent(Int.self, forKey: .has_access)
        
        title = try values.decodeIfPresent(String.self, forKey: .title)
        sessions = try values.decodeIfPresent([sessionFilemodel].self, forKey: .sessions)
       // sessionsnew =  try values.decodeIfPresent(sessionFilemodel.self, forKey: .sessionsnew)
       
    }

}
