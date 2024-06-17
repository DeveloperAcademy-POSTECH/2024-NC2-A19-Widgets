//
//  HomeViewModel.swift
//  NC2
//
//  Created by 이정동 on 6/17/24.
//

import Foundation

@Observable
final class HomeViewModel {
    private let jsonManager: JsonManager = JsonManager()
    
    private var engWords: [EngWord] = []
    var currentWord: EngWord?
    var isAlert: Bool = false
    
    init() {
        self.engWords = jsonManager.load()
        self.getRandomWord()
    }
    
    func getRandomWord() {
        self.currentWord = engWords.randomElement()
    }
}
