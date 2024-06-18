//
//  Date+ext.swift
//  NC2
//
//  Created by 이정동 on 6/17/24.
//

import Foundation

extension Date {
    var nextDay: Self {
        var componets = DateComponents()
        let calendar = Calendar.current
        
        let date = Date().addingTimeInterval(86400)
        
        componets.year = calendar.component(.year, from: date)
        componets.month = calendar.component(.month, from: date)
        componets.day = calendar.component(.day, from: date)
        
        
        return calendar.date(from: componets)!
    }
    
    var test: Self {
        var componets = DateComponents()
        let calendar = Calendar.current
        
        let date = Date().addingTimeInterval(300)
        
        componets.year = calendar.component(.year, from: date)
        componets.month = calendar.component(.month, from: date)
        componets.day = calendar.component(.day, from: date)
        componets.hour = calendar.component(.hour, from: date)
        componets.minute = calendar.component(.minute, from: date)
        
        return calendar.date(from: componets)!
    }
}
