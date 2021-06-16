//
//  Trainingdatalist.swift
//  MECA
//
//  Created by Macbook  on 30/05/21.
//

import Foundation
struct Trainingdatalist : Codable {
    
    let id : Int?
    let title : String?
    let description : String?
    let type : String?
    let survey_link : String?
    let created_at : String?
    let invitations : [Invitationsdata]?
    let updated_at : String?
    
    
    
     enum CodingKeys: String, CodingKey {
        case survey_link = "survey_link"
        case created_at = "created_at"
        case description = "description"
        case id = "id"
        case type = "type"
        case title = "title"
        case updated_at = "updated_at"
        case invitations = "invitations"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
       
        title = try values.decodeIfPresent(String.self, forKey: .title)
        
        description = try values.decodeIfPresent(String.self, forKey: .description)
       
        survey_link = try values.decodeIfPresent(String.self, forKey: .survey_link)
        
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        invitations = try values.decodeIfPresent([Invitationsdata].self, forKey: .invitations)
       
    }

}
