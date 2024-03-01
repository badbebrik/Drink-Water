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
            
            Image(plant.stages[plant.stages.count - 1])
                .resizable()
                .frame(width: 100, height: 100)
            
            Button {
                print("plant \(plant.name) was bought")
            } label: {
                HStack {
                    Text("100")
                        .font(.title2)
                        .foregroundStyle(.white)
                    Image("coin")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .frame(width: 100, height: 50)
                .background(.green)
                .cornerRadius(20)
                
            }
        }
        
    }
    
}


#Preview {
    
    PlantView(plant: Plant(name: "Sunflower", WaterVolumeToFinish: 3000, price: 200, stages: ["sunflower", "sunflower", "sunflower"]))
    
}
