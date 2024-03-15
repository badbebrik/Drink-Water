//
//  PlantsViewModel.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import SwiftUI

class PlantsViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    
    func fetchPlants() {
        let coreDataManager = CoreDataManager()
        if let allPlants = coreDataManager.getAllPlants() {
            plants = allPlants.filter { $0.currentFillness >= $0.totalToGrow }
        }
    }
}
