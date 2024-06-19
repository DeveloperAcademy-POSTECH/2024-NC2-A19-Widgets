//
//  EngWordManager.swift
//  NC2
//
//  Created by 이정동 on 6/18/24.
//

import Foundation
import WidgetKit

@Observable
class EngWordManager {
    static let shared = EngWordManager()
    private init() {
        self.words = load()

        self.setRandomWord()
    }
    
    private var words: [EngWord] = []
    var currentWord: EngWord?
    
    private func load() -> [EngWord] {
        let data: Data
        let fileName = "EngWord.json"

        guard let file = Bundle.main.url(forResource: fileName, withExtension: nil)
        else {
            fatalError("Couldn't find \(fileName) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(fileName) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode([EngWord].self, from: data)
        } catch {
            fatalError("Couldn't parse \(fileName) as \([EngWord].self):\n\(error)")
        }
    }
    
    func setRandomWord() {
        guard let word = words.randomElement() else { return }
        self.currentWord = word
        
        UserDefaults.group?.setWidgetData(word)
        
        WidgetCenter.shared.reloadTimelines(ofKind: "NC2Widget")
    }
}
