//
//  DrinkAddView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 13.03.2024.
//

import SwiftUI

struct DrinkAddView: View {
    let drinks: [Drink] = [
        Drink(id: UUID(), name: "Water", imageName: "water 2"),
        Drink(id: UUID(), name: "Coffee", imageName: "coffee"),
        Drink(id: UUID(), name: "Tea", imageName: "tea"),
    ]
    
    let waterVolumes = [100, 200, 300, 400, 500]
    
    @Binding var isShowingDetail: Bool
    @State private var selectedDrink: Drink?
    @State private var selectedVolume: Int?
    @Binding var progressDrop: CGFloat
    @Binding var todayDrinked: Int
    @Binding var dailyIntakeGoal: Int
    
    var body: some View {
        VStack {
            Text("Choose The Drink")
                .padding()
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(150))]) {
                    ForEach(drinks, id: \.id) { drink in
                        VStack {
                            Image(drink.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedDrink == drink ? Color.gray : Color.black, lineWidth: 2)
                                )
                                .onTapGesture {
                                    selectedDrink = drink
                                }
                            Text(drink.name)
                                .font(.caption)
                        }
                        .padding()
                    }
                }
                .padding()
            }
            
            Text("Choose Volume")
                .padding()
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(100))]) {
                    ForEach(waterVolumes, id: \.self) { volume in
                        VStack {
                            Text("\(volume)ml")
                                .font(.caption)
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedVolume == volume ? Color.gray : Color.black, lineWidth: 2)
                                )
                                .onTapGesture {
                                    selectedVolume = volume
                                }
                        }
                        .padding()
                    }
                }
                .padding()
            }
            
            Button(action: {
                todayDrinked += selectedVolume ?? 0
                progressDrop = CGFloat(Double(todayDrinked) / Double(dailyIntakeGoal))
                isShowingDetail = false
                
            }) {
                Text("Drink!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .frame(width: 300, height: 525)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(
            Button(action: {
                isShowingDetail = false
            }) {
                Text("Back")
                    .padding()
            },
            alignment: .topTrailing
        )
    }
}



#Preview {
    DrinkAddView(isShowingDetail: .constant(true), progressDrop: .constant(0.5), todayDrinked: .constant(0), dailyIntakeGoal: .constant(3000))
}
