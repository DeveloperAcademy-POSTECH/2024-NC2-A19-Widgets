//
//  HomeViewModel.swift
//  NC2
//
//  Created by 이정동 on 6/17/24.
//

import Foundation
import WidgetKit

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
}

extension HomeViewModel {
    func getRandomWord() {
        guard let word = engWords.randomElement() else { return }
        self.currentWord = word
        
        UserDefaults.group?.setWidgetData(word)
        
        WidgetCenter.shared.reloadTimelines(ofKind: "NC2Widget")
    }
}
