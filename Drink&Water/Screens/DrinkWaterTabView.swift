//
//  DrinkWaterTab.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI

import SwiftUI

struct DrinkWaterTabView: View {
    
    init() {
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                tabBarAppearance.backgroundColor = UIColor.white
                UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    var body: some View {
        TabView {
            ShopView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Shop")
                }
            
            PlantsView()
                .tabItem {
                    Image(systemName: "leaf")
                    Text("Plant")
                }
            
            TrackerView()
                .tabItem {
                    Image(systemName: "drop")
                    Text("Tracker")
                }
            
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            
        }
        .tabViewStyle(.automatic)
                .accentColor(.blue)
                
    }
    
}

#Preview {
    DrinkWaterTabView()
}

