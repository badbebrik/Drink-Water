//
//  ShopView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI

class ShopViewModel: ObservableObject {
    
    @Published var plantsToBuy: [Plant] = [
        Plant(id: UUID(), name: "cactus", totalToGrow: 1200, price: 100, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()),
        Plant(id: UUID(), name: "red tulip", totalToGrow: 1200, price: 200, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()),
        Plant(id: UUID(), name: "purple tulip", totalToGrow: 1200, price: 300, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()),
        Plant(id: UUID(), name: "apple", totalToGrow: 1200, price: 400, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date())
    ]
}

struct ShopView: View {
    @StateObject var viewModel = ShopViewModel()
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color(.brandBlue)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Spacer()
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
                }
                .padding()
                
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
                        ForEach(viewModel.plantsToBuy, id: \.name) { plant in
                            PlantShopView(plant: plant)
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
