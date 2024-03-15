//
//  PlantView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 28.02.2024.
//

import SwiftUI

struct PlantView: View {
    var plant: Plant;
    var body: some View {
        
        VStack(spacing: 20) {
            Text(plant.name)
                .font(.headline)
                .fontWeight(.bold)
    
            Image(plant.name + " " + "adult")
                .resizable()
                .frame(width: 70, height: 100)
        }
    }
}


#Preview {
    
    PlantView(plant: Plant(name: "red tulip", totalToGrow: 1200, price: 200, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()))
    
}
