//
//  PlantInfoOverlayView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 09.04.2024.
//

import SwiftUI

struct PlantInfoOverlayView: View {
    let plant: Plant
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            Image("\(plant.name) adult")
                .resizable()
                .frame(width: 150, height: 180)
            
            VStack {
                Text(plant.name.capitalized)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                HStack(alignment: .center) {
                    Text("Needs to grow: \(plant.totalToGrow) ml")
                    Image("drop")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                HStack(alignment: .center) {
                    Text("Cost: \(plant.price)")
                    Image("coin")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
            
    
        }
        
        .frame(width: 300, height: 500)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .overlay(
            Button(action: {
                onClose()
            }) {
                Image(systemName: "xmark")
                    .padding()
            },
            alignment: .topTrailing
        )
    }
}

#Preview {
    PlantInfoOverlayView(plant: Plant(id: UUID(), name: "apple", totalToGrow: 1200, price: 1500, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()), onClose: privet)
}

func privet() {
    
}
