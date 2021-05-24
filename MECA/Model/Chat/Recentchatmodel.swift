//
//  Recentchatmodel.swift
//  MECA
//
//  Created by Macbook  on 18/05/21.
//

import Foundation
// MARK: - Recentchat
struct Recentchatmodel: Codable {
    let id : Int?
    let user : Int?
    
    let chat_with : Int?
    let chatroom_id : Int?
    
    let chat_type : Int?
    let unread : Int?
    
    let is_admin : Int?
    let is_admin_chat : Int?
    
    let chat_with_is_admin : Int?
    let is_deleted : Int?
    
    let cleared_at : Int?
    let msgcount : Int?
    
    let created_at : String?
    let updated_at : String?
    let userprofile :LoginUserModel?
    let groupinfo : String?
    
    

    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user = "user"
        
        case chat_with = "chat_with"
        case chatroom_id = "chatroom_id"
        
        case chat_type = "chat_type"
        case unread = "unread"
        
        case is_admin = "is_admin"
        case is_admin_chat = "is_admin_chat"
        
        case chat_with_is_admin = "chat_with_is_admin"
        case is_deleted = "is_deleted"
        
        case cleared_at = "cleared_at"
        case msgcount = "msgcount"
        
        case created_at = "created_at"
        case updated_at = "updated_at"
        case userprofile = "userprofile"
        case groupinfo = "groupinfo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user = try values.decodeIfPresent(Int.self, forKey: .user)
        
        chat_with = try values.decodeIfPresent(Int.self, forKey: .chat_with)
        chatroom_id = try values.decodeIfPresent(Int.self, forKey: .chatroom_id)
        
        chat_type = try values.decodeIfPresent(Int.self, forKey: .chat_type)
        unread = try values.decodeIfPresent(Int.self, forKey: .unread)
        
        is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
        is_admin_chat = try values.decodeIfPresent(Int.self, forKey: .is_admin_chat)
        
        chat_with_is_admin = try values.decodeIfPresent(Int.self, forKey: .chat_with_is_admin)
        is_deleted = try values.decodeIfPresent(Int.self, forKey: .is_deleted)
        
        cleared_at = try values.decodeIfPresent(Int.self, forKey: .cleared_at)
        msgcount = try values.decodeIfPresent(Int.self, forKey: .msgcount)
      
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        userprofile = try values.decodeIfPresent(LoginUserModel.self, forKey: .userprofile)
        groupinfo = try values.decodeIfPresent(String.self, forKey: .groupinfo)
       
    }

}


