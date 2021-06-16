//
//  Trainingevent_files.swift
//  MECA
//
//  Created by Macbook  on 30/05/21.
//

import Foundation
struct trainingeventfiles : Codable {
    
    let filetype : String?
    
    let file : String?
    

    enum CodingKeys: String, CodingKey {

        
        case filetype = "filetype"
       
         case file = "file"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        filetype = try values.decodeIfPresent(String.self, forKey: .filetype)
        
        file = try values.decodeIfPresent(String.self, forKey: .file)
    }

}
