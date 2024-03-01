//
//  ShopView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI

struct ShopView: View {
    
    private let plantsToBuy: [Plant] = [Plant(name: "Sunflower1", WaterVolumeToFinish: 2000, price: 200, stages: ["sunflower"]), Plant(name: "Sunflower2", WaterVolumeToFinish: 2000, price: 200, stages: ["sunflower"]), Plant(name: "Sunflower3", WaterVolumeToFinish: 2000, price: 200, stages: ["sunflower"])]
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            
            Color(.brandBlue)
                .ignoresSafeArea()
            
            
            VStack(spacing: 20) {
                
                HStack() {
                    Text("100")
                        .frame(alignment: .trailing)
                        .font(.title)
                    Image("coin")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                
                
                Text("Shop")
                    .font(.system(size: 32, weight: .black))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .frame(width: 353, height: 26, alignment: .leading)
                
                
                
                Text("You can buy plants here and then grow")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                    .frame(width: 353, height: 26, alignment: .leading)
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(plantsToBuy, id: \.name) { plant in
                            PlantView(plant: plant)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    ShopView()
}
