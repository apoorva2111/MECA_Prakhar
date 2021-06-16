//
//  Document_News.swift
//  MECA
//




import Foundation
struct Document_News : Codable {
    let filetype : String?
    let name : String?
    let file : String?
    let plain_description : String?
    let info : String?
    enum CodingKeys: String, CodingKey {

       
        case filetype = "filetype"
        case name = "name"
        case info = "info"
        case file = "file"
        case plain_description = "plain_description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        filetype = try values.decodeIfPresent(String.self, forKey: .filetype)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        file = try values.decodeIfPresent(String.self, forKey: .file)
        plain_description = try values.decodeIfPresent(String.self, forKey: .plain_description)
        info = try values.decodeIfPresent(String.self, forKey: .info)
    }

}
