//
//  Adminchatusers.swift
//  MECA
//
/*
 {
avatar = "public/upload/users/default.png";
"display_user_name" = "Haruna Tozawa";
id = 22;
"is_admin" = 1;
"last_call_at" = 1621992653000;
}
 */
//  Created by Macbook  on 18/05/21.
//

import Foundation
// MARK: - Recentchat
struct Adminchatusers: Codable {
    let id : Int?
   
    let display_user_name : String?
    
    let avatar : String?
    
    
    let last_call_at : Int?
    
    let is_admin : Int?

    enum CodingKeys: String, CodingKey {
        
       
        case display_user_name = "display_user_name"
        
        case avatar = "avatar"
        
        case id = "id"
        
        case last_call_at = "last_call_at"
        
        
        case is_admin = "is_admin"
        
        
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        
        display_user_name = try values.decodeIfPresent(String.self, forKey: .display_user_name)
       
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        
        
        last_call_at = try values.decodeIfPresent(Int.self, forKey: .last_call_at)
        
        is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
    }

}



