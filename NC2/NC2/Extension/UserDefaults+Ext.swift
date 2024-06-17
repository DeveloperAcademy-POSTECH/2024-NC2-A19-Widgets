//
//  UserDefaults+Ext.swift
//  NC2
//
//  Created by 이정동 on 6/17/24.
//

import Foundation

extension UserDefaults {
    static let group: UserDefaults? = UserDefaults(suiteName: "group.nc2.widgets.com")
    
    func setWidgetData(_ data: EngWord) {
        if let encodedData = try? JSONEncoder().encode(data) {
            self.set(encodedData, forKey: "widget")
        }
    }
    
    func getWidgetData() -> EngWord? {
        if let savedData = self.data(forKey: "widget") {
            if let decodedData = try? JSONDecoder().decode(EngWord.self, from: savedData) {
                return decodedData
            }
        }
        return nil
    }
}
