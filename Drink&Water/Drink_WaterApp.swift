//
//  Drink_WaterApp.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 19.02.2024.
//

import SwiftUI

@main
struct Drink_WaterApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
        .environment(\.locale, Locale.init(identifier: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"))
    }
}
