//
//  Pdca_uploadModel.swift
//  MECA
//
//  Created by Macbook  on 04/06/21.
//

import Foundation
// MARK: - Welcome
struct Pdca_uploadModel: Codable {
    let id, pdca, session, user: Int?
    let isAdminUpload, status, noOfAttempts: Int?
    let documentLink, feedback, createdAt,display_status_text,display_lable_text,text_color, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, pdca, session, user
        case isAdminUpload = "is_admin_upload"
        case status
        case noOfAttempts = "no_of_attempts"
        case documentLink = "document_link"
        case feedback
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case text_color = "text_color"
        case display_lable_text = "display_lable_text"
         case display_status_text = "display_status_text"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        
        pdca = try values.decodeIfPresent(Int.self, forKey: .pdca)
        feedback = try values.decodeIfPresent(String.self, forKey: .feedback)
        documentLink = try values.decodeIfPresent(String.self, forKey: .documentLink)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        session = try values.decodeIfPresent(Int.self, forKey: .session)
        user = try values.decodeIfPresent(Int.self, forKey: .user)
        noOfAttempts = try values.decodeIfPresent(Int.self, forKey: .noOfAttempts)
        
        isAdminUpload = try values.decodeIfPresent(Int.self, forKey: .isAdminUpload)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        text_color = try values.decodeIfPresent(String.self, forKey: .text_color)
        display_status_text = try values.decodeIfPresent(String.self, forKey: .display_status_text)
        display_lable_text = try values.decodeIfPresent(String.self, forKey: .display_lable_text)
       
       
    }
}
