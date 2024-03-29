//
//  DrinkAddView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 13.03.2024.
//

import SwiftUI

import Foundation


struct DrinkAddView: View {
    let drinks: [Drink] = [
        Drink(id: UUID(), name: "Water", imageName: "water", volume: 0, coefficient: 1),
        Drink(id: UUID(), name: "Coffee", imageName: "coffee", volume: 0, coefficient: 0.7),
        Drink(id: UUID(), name: "Tea", imageName: "tea", volume: 0, coefficient: 1),
        Drink(id: UUID(), name: "Milk", imageName: "milk", volume: 0, coefficient: 1),
        Drink(id: UUID(), name: "Juice", imageName: "juice", volume: 0, coefficient: 0.8),
        Drink(id: UUID(), name: "Soda", imageName: "soda", volume: 0, coefficient: 0.9),
        Drink(id: UUID(), name: "Beer", imageName: "beer", volume: 0, coefficient: 0.5),
        Drink(id: UUID(), name: "Wine", imageName: "wine", volume: 0, coefficient: 0.6),
        Drink(id: UUID(), name: "Champagn", imageName: "champagn", volume: 0, coefficient: 0.6),
        
    ]
    
    func addDrink(_ drink: Drink) {
        trackerViewModel.todayDrinks.append(drink)
    }
    
    let waterVolumes = [100, 200, 300, 400, 500]
    
    @Binding var isShowingDetail: Bool
    @State private var selectedDrink: Drink?
    @State private var selectedVolume: Int?
    @ObservedObject var trackerViewModel: TrackerViewModel
    
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
                                        .stroke(Color.black, lineWidth: 2)
                                        .fill(selectedDrink == drink ? Color.gray.opacity(0.5) : Color.clear)
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
            .scrollIndicators(.hidden)
            
            Text("Choose Volume")
                .padding()
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(100))]) {
                    ForEach(waterVolumes, id: \.self) { volume in
                        VStack {
                            Text("\(volume)ml")
                                .font(.title3)
                                .frame(width: 70, height: 25)
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
                
            }
            .scrollIndicators(.hidden)
            
            Button(action: {
                let coreDataManager = CoreDataManager()
                
                if var selectedDrink = selectedDrink {
                    trackerViewModel.todayWaterIntake += Double(Double(selectedVolume ?? 0) * selectedDrink.coefficient)
                    trackerViewModel.progressDrop = Double(trackerViewModel.todayWaterIntake) / trackerViewModel.dailyWaterIntakeGoal
                    if let selectedVolume = selectedVolume {
                        let volume = Double(selectedVolume)
                        let totalVolume = volume * (selectedDrink.coefficient)
                        selectedDrink.volume = Int(totalVolume)
                    } else {
                        selectedDrink.volume = 0
                    }
                    addDrink(selectedDrink)
                    coreDataManager.saveDrink(selectedDrink)
                }
                if var currentPlant = trackerViewModel.currentGrowingPlant {
                    if trackerViewModel.checkStage(plant: currentPlant) != "adult" {
                        currentPlant.currentFillness += Int(Double(selectedVolume ?? 0) * (selectedDrink?.coefficient ?? 1)) 
                        coreDataManager.updateFirstPlantCurrentFillness(newFillness: currentPlant.currentFillness )
                        
                        if trackerViewModel.checkStage(plant: currentPlant) == "adult" {
                            coreDataManager.addBalance(Int32(1.5 * Double(currentPlant.price)))
                        }
                    }
                    
                }
                
                coreDataManager.updateTodayWaterIntake(Double(trackerViewModel.todayWaterIntake))
                
                trackerViewModel.fetchData()
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
    DrinkAddView(isShowingDetail: .constant(true), trackerViewModel: TrackerViewModel())
}
