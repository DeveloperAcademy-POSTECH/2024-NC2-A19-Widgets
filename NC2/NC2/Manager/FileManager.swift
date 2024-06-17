//
//  FileManager.swift
//  NC2
//
//  Created by 대여품 on 6/17/24.
//

import Foundation

final class FileManager {
    
    func load(_ filename: String) -> [EngWord] {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode([EngWord].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \([EngWord].self):\n\(error)")
        }
    }
}
