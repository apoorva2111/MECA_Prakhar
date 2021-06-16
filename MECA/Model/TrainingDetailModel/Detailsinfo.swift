//
//  Detailsinfo.swift
//  MECA
//
//  Created by Macbook  on 30/05/21.
//

import Foundation
struct Detailsinfo : Codable {
    let created_at : String?
    let description : String?
    let id : Int?
    let has_access : Int?
    let is_public : Int?
    let likes : Int?
    let title : String?
    let type : String?
    let survey_link : String?
    let updated_at : String?
    
    
    let trainingeventfile : [trainingeventfiles]?
    let invitations : [Invitationsdata]?
    let triaingvideo : [Trainingvideolinks]?
    let triainguploads : [Traininguploadsmodel]?
    
    
    
    
     enum CodingKeys: String, CodingKey {
        case survey_link = "survey_link"
        case created_at = "created_at"
        case description = "description"
        case id = "id"
        case type = "type"
        case is_public = "is_public"
        case likes = "likes"
       case title = "title"
        case updated_at = "updated_at"
         case has_access = "has_access"
        
        case invitations = "invitations"
        case trainingeventfile = "event_files"
        case triaingvideo = "video_links"
         case triainguploads = "uploads"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
       
        is_public = try values.decodeIfPresent(Int.self, forKey: .is_public)
        
        description = try values.decodeIfPresent(String.self, forKey: .description)
       
        survey_link = try values.decodeIfPresent(String.self, forKey: .survey_link)
        
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        
        has_access = try values.decodeIfPresent(Int.self, forKey: .has_access)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        trainingeventfile = try values.decodeIfPresent([trainingeventfiles].self, forKey: .trainingeventfile)
        invitations = try values.decodeIfPresent([Invitationsdata].self, forKey: .invitations)
        triaingvideo = try values.decodeIfPresent([Trainingvideolinks].self, forKey: .triaingvideo)
        
        triainguploads = try values.decodeIfPresent([Traininguploadsmodel].self, forKey: .triainguploads)
       
    }

}
