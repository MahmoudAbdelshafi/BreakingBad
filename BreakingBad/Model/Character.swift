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
    let status: Status?
    let nickname: String?
    let appearance: [Int]?
    let portrayed: String?
    let category: Category?
    let betterCallSaulAppearance: [Int]?

    enum CodingKeys: String, CodingKey {
        case charID = "char_id"
        case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }
}

enum Category: String, Codable {
    case betterCallSaul = "Better Call Saul"
    case breakingBad = "Breaking Bad"
    case breakingBadBetterCallSaul = "Breaking Bad, Better Call Saul"
}

enum Status: String, Codable {
    case alive = "Alive"
    case deceased = "Deceased"
    case presumedDead = "Presumed dead"
    case unknown = "Unknown"
}

