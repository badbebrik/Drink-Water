//
//  DrinkAddView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 13.03.2024.
//

import SwiftUI


struct DrinkAddView: View {
    
    let drinks: [Drink] = [
        Drink(id: UUID(), name: "Water", imageName: "water", volume: 0, coefficient: 1),
        Drink(id: UUID(), name: "Coffee", imageName: "coffee", volume: 0, coefficient: 0.83),
        Drink(id: UUID(), name: "Tea", imageName: "tea", volume: 0, coefficient: 1),
        Drink(id: UUID(), name: "Milk", imageName: "milk", volume: 0, coefficient: 1),
        Drink(id: UUID(), name: "Juice", imageName: "juice", volume: 0, coefficient: 0.86),
        Drink(id: UUID(), name: "Soda", imageName: "soda", volume: 0, coefficient: 0.88),
        Drink(id: UUID(), name: "Beer", imageName: "beer", volume: 0, coefficient: 0.9),
        Drink(id: UUID(), name: "Wine", imageName: "wine", volume: 0, coefficient: 0.85),
        Drink(id: UUID(), name: "Champagn", imageName: "champagn", volume: 0, coefficient: 0.8),
        
    ]
    
    @State private var isCustomVolume = false
    @State private var customVolume: String = ""
    @State private var isErrorCustomVolumeCasting = false
    
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
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .top], 16)
            
        
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(150))]) {
                    ForEach(drinks, id: \.id) { drink in
                        VStack {
                            Image(drink.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 2)
                                        .background(selectedDrink == drink ? Color.gray.opacity(0.5) : Color.clear)
                                )
                            
                                .onTapGesture {
                                    selectedDrink = drink
                                }
                            Text(LocalizationManager.shared.localizeString(forKey: drink.name, language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"))
                                .font(.caption)
                        }
                        .padding()
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            Text("Choose Volume")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .top], 16)
            
            
            Toggle("Custom Volume", isOn: $isCustomVolume)
                .padding()

           
            if (!isCustomVolume) {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem(.fixed(100))]) {
                        ForEach(waterVolumes, id: \.self) { volume in
                            VStack {
                                Text("\(volume)ml")
                                    .font(.title3)
                                    .frame(width: 70, height: 35)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 2)
                                            .background(selectedVolume == volume ? Color.gray.opacity(0.5) : Color.clear)
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
            } else {
                HStack {
                    TextField("Enter volume", text: $customVolume)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Text("ml")
                        .padding(.trailing, 16)
                }
            
            }
            
            if (isErrorCustomVolumeCasting) {
                Text("Please type whole number in this field!")
                    .font(.caption)
                    .foregroundStyle(.red)
                
            }
            
            
            Button(action: {
                
                isErrorCustomVolumeCasting = false
                
                if (isCustomVolume) {
                    if let selectedVolume = Int(customVolume) {
                        self.selectedVolume = selectedVolume
                        
                    } else {
                        isErrorCustomVolumeCasting = true
                        return
                    }
                }
                
                HealthKitManager.shared.requestHealthKitAuthorization()
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
                            coreDataManager.setPlantFinishDate(date: Date())
                            trackerViewModel.activeAlert = .growCompleted
                            trackerViewModel.showAlert = true
                        }
                    }
                    
                }
                
                coreDataManager.updateTodayWaterIntake(Double(trackerViewModel.todayWaterIntake))
                
                if (trackerViewModel.todayWaterIntake >= trackerViewModel.dailyWaterIntakeGoal) {
                    if (!coreDataManager.isTodayGoalCompleted) {
                        coreDataManager.addBalance(100)
                        coreDataManager.isTodayGoalCompleted = true
                        trackerViewModel.activeAlert = .goalCompleted
                        trackerViewModel.showAlert = true
                    }
                }
                
                HealthKitManager.shared.addDrinkToHealthKit(volume: Double(selectedVolume ?? 0), coefficient: selectedDrink?.coefficient ?? 1)
                
                trackerViewModel.fetchData()
                isShowingDetail = false
                
            }) {
                Text("Drink!")
                    .frame(width: 100)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .frame(width: 350, height: 575)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(
            Button(action: {
                isShowingDetail = false
            }) {
                Image(systemName: "xmark")
                    .padding()
            },
            alignment: .topTrailing
        )
    }
}



#Preview {
    DrinkAddView(isShowingDetail: .constant(true), trackerViewModel: TrackerViewModel())
}
