//
//  Character.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import Foundation

// MARK: - Character

struct Character: Codable {
    let charID: Int?
    let name: String?
    let birthday: String?
    let occupation: [String]?
    let img: String?
    let nickname: String?

    enum CodingKeys: String, CodingKey {
        case charID = "char_id"
        case name, birthday, occupation, img, nickname
    }
}
