//
//  DrinkWaterTab.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI

import SwiftUI

struct DrinkWaterTabView: View {
    
    @State private var selectedTab = 2
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ShopView(viewModel: ShopViewModel())
                .tabItem {
                    Image(systemName: "cart")
                    Text("Shop")
                }
                .tag(0)
            
            PlantsView()
                .tabItem {
                    Image(systemName: "leaf")
                    Text("Plant")
                }
                .tag(1)
            
            TrackerView()
                .tabItem {
                    Image(systemName: "drop")
                    Text("Tracker")
                }
                .tag(2)
            
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
                .tag(3)
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(4)
            
        }
        .tabViewStyle(.automatic)
        .accentColor(.blue)
    }
    
}

#Preview {
    DrinkWaterTabView()
}

