//
//  ValuesFromTMC.swift
//  MECA
//
//  Created by Macbook  on 06/07/21.
//

import Foundation
struct ValuesFromTMC:Codable {
    let onlyforpromotions : ForPromotionsvalue?
    //let onlyforTMCS : [ForTMCSValue]?
    
    enum CodingKeys: String, CodingKey {
         case onlyforpromotions = "promotion"
       // case onlyforTMCS = "tmcs"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        onlyforpromotions = try values.decodeIfPresent(ForPromotionsvalue.self, forKey: .onlyforpromotions)
        //onlyforTMCS = try values.decodeIfPresent([ForTMCSValue].self, forKey: .onlyforTMCS)
        
    }
}
