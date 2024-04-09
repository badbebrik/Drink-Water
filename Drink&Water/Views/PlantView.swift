//
//  PlantView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 28.02.2024.
//

import SwiftUI

struct PlantView: View {
    var plant: Plant;
    var plantImageName: String;
    var width: CGFloat;
    var height: CGFloat;
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text(LocalizationManager.shared.localizeString(forKey: plant.name, language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en").capitalized)
                .font(.headline)
                .fontWeight(.bold)
            
            Image(plantImageName)
                .resizable()
                .frame(width: width, height: height)
        }
    }
}


#Preview {
    
    PlantView(plant: Plant(id: UUID(), name: "red tulip", totalToGrow: 1200, price: 200, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()), plantImageName: "red tulip adult", width: 50, height: 70)
    
}
