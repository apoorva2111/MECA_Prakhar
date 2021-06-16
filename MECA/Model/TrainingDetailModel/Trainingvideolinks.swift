//
//  Trainingvideolinks.swift
//  MECA
//
//  Created by Macbook  on 30/05/21.
//

import Foundation
struct Trainingvideolinks : Codable {
    
    let link : String?
    
    let title : String?
    

    enum CodingKeys: String, CodingKey {

        
        case link = "link"
       
         case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        link = try values.decodeIfPresent(String.self, forKey: .link)
        
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
