//
//  ShopView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI

struct ShopView: View {
    @StateObject var viewModel: ShopViewModel
    @State private var selectedPlant: Plant? = nil
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 100, maximum: 300)),
        GridItem(.flexible(minimum: 100, maximum: 300))
    ]
    
    var body: some View {
        ZStack {
            Color(.brandBlue)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    HStack() {
                        Text("\(viewModel.balance)")
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
                            PlantShopView(shopViewModel: viewModel, plant: plant)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .onTapGesture {
                                    self.selectedPlant = plant // При нажатии устанавливаем выбранное растение
                                }
                        }
                    }
                }
                
            }
            .blur(radius: selectedPlant != nil ? 20 : 0)
            
            if let plant = selectedPlant {
                PlantInfoOverlayView(plant: plant) {
                    self.selectedPlant = nil
                }
                .transition(.opacity)
            }
        }
        .onAppear() {
            viewModel.fetchBalance()
        }
    }
    
}
