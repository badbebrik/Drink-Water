//
//  PlantShopView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import SwiftUI

struct PlantShopView: View {
    @State private var showAlert = false
    @State private var successAlert = false
    
    @ObservedObject var shopViewModel: ShopViewModel
    
    var plant: Plant
    
    var body: some View {
        VStack {
            PlantView(plant: plant, plantImageName: plant.name + " " + "adult", width: 65, height: 90)
            Button(action: {
                if isPlantAlreadyExists() {
                    showAlert = true
                } else {
                    shopViewModel.balance -= Int32(plant.price)
                    successAlert = true
                    savePlant()
                }
            }) {
                HStack {
                    Text("\(plant.price)")
                        .font(.title2)
                        .foregroundColor(.white)
                    Image("coin")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .frame(width: 125, height: 50)
                .background(shopViewModel.balance < Int32(plant.price) ? Color.gray : Color.green)
                .cornerRadius(20)
            }
        }
        .disabled(shopViewModel.balance < Int32(plant.price))
        .alert(isPresented: Binding<Bool>(
            get: { showAlert || successAlert },
            set: { _ in
                showAlert = false
                successAlert = false
            }
        )) {
            if showAlert {
                return Alert(title: Text("Error"), message: Text("You already have a growing plant!"), dismissButton: .default(Text("OK")))
            } else if successAlert {
                return Alert(title: Text("Success"), message: Text("You have successfully purchased the \(LocalizationManager.shared.localizeString(forKey: plant.name, language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en")). To grow it, you need to drink \(plant.totalToGrow) milliliters of water."), dismissButton: .default(Text("OK")))
            } else {
                return Alert(title: Text(""), message: Text(""), dismissButton: .default(Text("OK")))
            }
        }
        
    }
    
    func isPlantAlreadyExists() -> Bool {
        let coreDataManager = CoreDataManager()
        if let plants = coreDataManager.getAllPlants() {
            for existingPlant in plants {
                print(existingPlant.currentFillness)
                print(existingPlant.totalToGrow)
                if existingPlant.currentFillness < existingPlant.totalToGrow {
                    return true
                }
            }
        }
        return false
    }
    
    func savePlant() {
        let coreDataManager = CoreDataManager()
        coreDataManager.savePlant(id: plant.id, name: plant.name, totalToGrow: plant.totalToGrow, price: plant.price, startGrowDate: plant.startGrowDate, currentFillness: plant.currentFillness, finishGrowDate: plant.finishGrowDate)
        coreDataManager.updateBalance(shopViewModel.balance)
    }
}
#Preview {
    PlantShopView(shopViewModel: ShopViewModel(), plant: Plant(id: UUID(), name: "red tulip", totalToGrow: 1200, price: 200, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()))
}
