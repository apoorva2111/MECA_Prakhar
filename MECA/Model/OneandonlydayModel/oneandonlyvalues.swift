//
//  oneandonlyvalues.swift
//  MECA
//
//  Created by Macbook  on 05/07/21.
//
//
////*
/*{
"cover_image" = "public/upload/oneandonlyday/cover/60a64af30a691.JPG";
"created_at" = "2021-05-20 17:11:39";
description = "Humanitarian Mission Rescue\nSense of responsibility";
id = 5;
"plain_description" = "Humanitarian Mission Rescue\nSense of responsibility";
title = "[TIQ]  One and Only Day Story Sharing ~Humanitarian Mission Rescue 1~";
"writer_name" = "Katsuya Kawashima(Admin)";
}
*/

import Foundation
struct oneandonlyvalues:Codable {
    let id: Int?
    let title: String?
    let  description: String?
    let plain_description : String?
    let cover_image : String?
    let created_at : String?
    let writer_name : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
         case title = "title"
         case description = "description"
         case plain_description = "plain_description"
         case cover_image = "cover_image"
         case created_at = "created_at"
         case writer_name = "writer_name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
    
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        plain_description = try values.decodeIfPresent(String.self, forKey: .plain_description)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        writer_name = try values.decodeIfPresent(String.self, forKey: .writer_name)
    }
    
}
