//
//  Adminchatusers.swift
//  MECA
//
//  Created by Macbook  on 18/05/21.
//

import Foundation
// MARK: - Recentchat
struct Adminchatusers: Codable {
    let id : Int?
    let email : String?
    let phone : String?
    let username : String?
    let status : Int?
    let reset_token : String?
    let avatar : String?
    
    let firebaseid : String?
    let firebasepassword : String?
    let last_call_at : Int?
    let created_at : String?
    let updated_at : String?
    let is_admin : Int?
    
    
    let role : Int?
    
    
    
    

    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case email = "email"
        case phone = "phone"
        case username = "username"
        case status = "status"
        case reset_token = "reset_token"
        case avatar = "avatar"
        
        case firebaseid = "firebaseid"
        case firebasepassword = "firebasepassword"
        case last_call_at = "last_call_at"
        case created_at = "created_at"
        case updated_at = "updated_at"
        
        case is_admin = "is_admin"
        case role = "role"
        
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        reset_token = try values.decodeIfPresent(String.self, forKey: .reset_token)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        
        firebaseid = try values.decodeIfPresent(String.self, forKey: .firebaseid)
        firebasepassword = try values.decodeIfPresent(String.self, forKey: .firebasepassword)
        last_call_at = try values.decodeIfPresent(Int.self, forKey: .last_call_at)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
        
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        
        
       
    }

}



