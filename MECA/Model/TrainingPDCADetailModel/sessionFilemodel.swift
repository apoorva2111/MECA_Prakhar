//
//  sessionFilemodel.swift
//  MECA
//
//  Created by Macbook  on 04/06/21.
//
/*
 {
                 "id": 10,
                 "pdca_training": 4,
                 "session_name": "PDCA Day 1 Lecture Video",
                 "session_file": "public/upload/pdca/quiz/6066b72658292.xlsx",
                 "created_at": "2021-04-02 11:48:14",
                 "updated_at": "2021-04-02 11:48:14",
                 "is_viewed": 1,
                 "is_completed": 0,
                 "upload_disabled": 1,
                 "videos": [
                     {
                         "id": 19,
                         "pdca": 4,
                         "session": 10,
                         "title": "PDCA Day 1 Lecture Video <Arabic>",
                         "info": "",
                         "video_link": "https://youtu.be/zxiwTSDHeak",
                         "type": 2,
                         "created_at": "2021-04-02 11:48:14",
                         "updated_at": "2021-04-06 06:44:20",
                         "is_viewed": 1
                     }
                 ],
                 "uploads": [
                     {
                         "id": 28,
                         "pdca": 4,
                         "session": 10,
                         "user": 2,
                         "is_admin_upload": 0,
                         "status": 2,
                         "no_of_attempts": 1,
                         "document_link": "public/upload/pdca/reports/60b8f4bea266a.pdf",
                         "feedback": "",
                         "created_at": "2021-06-03 20:56:54",
                         "updated_at": "2021-06-03 21:59:04"
                     },
                     {
                         "id": 29,
                         "pdca": 4,
                         "session": 10,
                         "user": 2,
                         "is_admin_upload": 1,
                         "status": 0,
                         "no_of_attempts": 1,
                         "document_link": "public/upload/pdca/reports/60b903500c855.pdf",
                         "feedback": "",
                         "created_at": "2021-06-03 21:59:04",
                         "updated_at": "2021-06-03 21:59:04"
                     },
                     {
                         "id": 30,
                         "pdca": 4,
                         "session": 10,
                         "user": 2,
                         "is_admin_upload": 0,
                         "status": 0,
                         "no_of_attempts": 2,
                         "document_link": "public/upload/pdca/reports/60b903622ada5.pdf",
                         "feedback": "",
                         "created_at": "2021-06-03 21:59:22",
                         "updated_at": "2021-06-03 21:59:22"
                     }
                 ]
             }
 */
import Foundation
struct sessionFilemodel : Codable {
    
    let id, pdcaTraining: Int?
        let sessionName, sessionFile, createdAt, updatedAt: String?
        let isViewed, isCompleted, uploadDisabled: Int?
    let videos : [Pdca_VideosModel]?
    let uploads :[Pdca_uploadModel]?
    
    

        enum CodingKeys: String, CodingKey {
            case id
            case pdcaTraining = "pdca_training"
            case sessionName = "session_name"
            case sessionFile = "session_file"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case isViewed = "is_viewed"
            case isCompleted = "is_completed"
            case uploadDisabled = "upload_status"
             case videos = "videos"
             case uploads = "uploads"
        }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        
        pdcaTraining = try values.decodeIfPresent(Int.self, forKey: .pdcaTraining)
        sessionName = try values.decodeIfPresent(String.self, forKey: .sessionName)
        sessionFile = try values.decodeIfPresent(String.self, forKey: .sessionFile)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        uploadDisabled = try values.decodeIfPresent(Int.self, forKey: .uploadDisabled)
        isCompleted = try values.decodeIfPresent(Int.self, forKey: .isCompleted)
        isViewed = try values.decodeIfPresent(Int.self, forKey: .isViewed)
        videos = try values.decodeIfPresent([Pdca_VideosModel].self, forKey: .videos)
        uploads = try values.decodeIfPresent([Pdca_uploadModel].self, forKey: .uploads)
    }

}
