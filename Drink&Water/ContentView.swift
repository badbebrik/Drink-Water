//
//  ContentView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 19.02.2024.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    let coreDataManager = CoreDataManager()
    
    var body: some View {
        if coreDataManager.isUserRegistered() {
            let user = coreDataManager.getUserData()!
            DrinkWaterTabView()
        } else {
            OnboardingView()
        }
        
    }
}

#Preview {
    ContentView()
}



