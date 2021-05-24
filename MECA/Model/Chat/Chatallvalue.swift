//
//  Chatallvalue.swift
//  MECA
//
//  Created by Macbook  on 18/05/21.
//

import Foundation


// MARK: - DataClass
struct Chatallvalue: Codable {
    let recentchats: [Recentchatmodel]?
    let users: [Chatusers]?
    let adminusers: [Adminchatusers]?
    
    enum CodingKeys: String, CodingKey {

        case recentchats = "recentchats"
        case users = "users"
        
        case adminusers = "adminusers"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        recentchats = try values.decodeIfPresent([Recentchatmodel].self, forKey: .recentchats)
        users = try values.decodeIfPresent([Chatusers].self, forKey: .users)
        adminusers = try values.decodeIfPresent([Adminchatusers].self, forKey: .adminusers)
        
    }

}
