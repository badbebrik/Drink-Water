//
//  PlantsViewModel.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import SwiftUI

class PlantsViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    
    
    @Published var selectedPlantForDeletion: Plant?
    @Published var selectedPlantForDetail: Plant?
    @Published var showingDeleteAlert = false 
    let coreDataManager = CoreDataManager()
    
    func fetchPlants() {
        let coreDataManager = CoreDataManager()
        if let allPlants = coreDataManager.getAllPlants() {
            plants = allPlants.filter { $0.currentFillness >= $0.totalToGrow }
        }
    }
    
    func deletePlant() {
        if let selectedPlantForDeletion = selectedPlantForDeletion {
            coreDataManager.deletePlantById(id: selectedPlantForDeletion.id)
        }
        fetchPlants()
    }
}
