//
//  SpecialsiteData.swift
//  MECA
//
//  Created by Macbook  on 20/07/21.
//


import Foundation
struct SpecialsiteData : Codable {
    let special_sites : [Special_sites]?
    let mecad_information : [Mecad_information]?
    let distributor_information : [Distributor_information]?

    enum CodingKeys: String, CodingKey {

        case special_sites = "special_sites"
        case mecad_information = "mecad_information"
        case distributor_information = "distributor_information"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        special_sites = try values.decodeIfPresent([Special_sites].self, forKey: .special_sites)
        mecad_information = try values.decodeIfPresent([Mecad_information].self, forKey: .mecad_information)
        distributor_information = try values.decodeIfPresent([Distributor_information].self, forKey: .distributor_information)
    }

}
