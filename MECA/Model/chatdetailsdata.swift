//
//  chatdetailsdata.swift
//  MECA
/*
 
 avatar = "public/upload/distributors/users/5e6b89980be34.jpeg";
 "created_at" = 1585212214289;
 fileurl = "-";
 isadmin = 0;
 isfile = 0;
 message = HI;
 "user_id" = 2;
 username = Muruganantham;
 */
//
//  Created by Macbook  on 25/05/21.
//

import Foundation
struct chatdetailsdata: Codable {
    
    let avatar : String?
    let created_at : String?
    let fileurl : String?
    let isadmin : Int?
    let  isfile : Int?
    let message: String?
    let user_id : Int?
    let username: String?
    
 
    enum CodingKeys: String, CodingKey {
        case avatar = "avatar"
         case created_at = "created_at"
         case fileurl = "fileurl"
        case isadmin = "isadmin"
        case isfile = "isfile"
         case message = "message"
        case user_id = "user_id"
         case username = "username"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        fileurl = try values.decodeIfPresent(String.self, forKey: .fileurl)
        isadmin = try values.decodeIfPresent(Int.self, forKey: .isadmin)
        isfile = try values.decodeIfPresent(Int.self, forKey: .isfile)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        username = try values.decodeIfPresent(String.self, forKey: .username)
    }
}
