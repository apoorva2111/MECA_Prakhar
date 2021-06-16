//
//  Traininguploadsmodel.swift
//  MECA
//
//  Created by Macbook  on 30/05/21.
//

import Foundation
struct Traininguploadsmodel: Codable {
    let download_link : String?
    let download_status : Int?
    let display_text : String?
    let type_lable : String?
    let upload_status : Int?
    let revised_link : String?
    let text_color : String?
    let type : String?
    
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case download_link = "download_link"
         case download_status = "download_status"
         case display_text = "display_text"
         case type_lable = "type_lable"
         case upload_status = "upload_status"
         case revised_link = "revised_link"
         case text_color = "text_color"
         case type = "type"
        
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        download_link = try values.decodeIfPresent(String.self, forKey: .download_link)
        download_status = try values.decodeIfPresent(Int.self, forKey: .download_status)
        display_text = try values.decodeIfPresent(String.self, forKey: .display_text)
        type_lable = try values.decodeIfPresent(String.self, forKey: .type_lable)
        upload_status = try values.decodeIfPresent(Int.self, forKey: .upload_status)
        revised_link = try values.decodeIfPresent(String.self, forKey: .revised_link)
        
        text_color = try values.decodeIfPresent(String.self, forKey: .text_color)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        
        
        
        
        
        
    }
    
}
