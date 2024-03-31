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
    
    
    func localizedString(forKey key: String, value: String? = nil, language: String) -> String {
        let bundle = Bundle.forLanguage(language) ?? Bundle.main
        return NSLocalizedString(key, bundle: bundle, value: value ?? "", comment: "")
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text(localizedString(forKey: plant.name, language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en").capitalized)
                .font(.headline)
                .fontWeight(.bold)
            
            Image(plantImageName)
                .resizable()
                .frame(width: 70, height: 100)
        }
    }
}


#Preview {
    
    PlantView(plant: Plant(id: UUID(), name: "red tulip", totalToGrow: 1200, price: 200, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()), plantImageName: "red tulip adult")
    
}
