//
//  EngWord.swift
//  NC2
//
//  Created by 이정동 on 6/17/24.
//

import Foundation

struct EngWord: Codable {
    var word: String
    var meaning: String
    var partOfSpeech: String
    var examples: [Sentence]
    
    enum CodingKeys: String, CodingKey {
        case word, meaning, examples
        case partOfSpeech = "part_of_speech"
    }
}

struct Sentence: Codable {
    var english: String
    var korean: String
    
    enum CodingKeys: String, CodingKey {
        case english = "en"
        case korean = "ko"
    }
}
