//
//  Characters.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

struct CharactersResponse: Codable {
    var charID: Int?
    var name: String?
    var occupation: [String]?
    var img: String?
    var nickname: String?
    var appearance: [Int]?
    var portrayed: String?
    var category: String?


    enum CodingKeys: String, CodingKey {
        case charID = "char_id"
        case name, occupation, img, nickname, appearance, portrayed, category
    }
}

typealias Characters = [CharactersResponse]
