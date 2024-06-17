//
//  NC2App.swift
//  NC2
//
//  Created by 이정동 on 6/16/24.
//

import SwiftUI

@main
struct NC2App: App {
    @State private var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(homeViewModel)
        }
    }
}
