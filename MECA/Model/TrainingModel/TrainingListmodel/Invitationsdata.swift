//
//  Invitationsdata.swift
//  MECA
//
//  Created by Macbook  on 30/05/21.
//

import Foundation
struct Invitationsdata : Codable {
    let name : String?
    let filetype : String?
    let filename : String?
    let file : String?
    

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case filetype = "filetype"
        case filename = "filename"
         case file = "file"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        filetype = try values.decodeIfPresent(String.self, forKey: .filetype)
        filename = try values.decodeIfPresent(String.self, forKey: .filename)
        file = try values.decodeIfPresent(String.self, forKey: .file)
    }

}
