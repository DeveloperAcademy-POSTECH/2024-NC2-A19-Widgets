//
//  FileManager.swift
//  NC2
//
//  Created by 대여품 on 6/17/24.
//

import Foundation

final class JsonManager {
    
    func load() -> [EngWord] {
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
}
