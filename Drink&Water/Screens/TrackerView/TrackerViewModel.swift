//
//  TrackerViewModel.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import SwiftUI

class TrackerViewModel: ObservableObject {
    @Published var progress: CGFloat = 0.5
    @Published var startAnimation: CGFloat = 0
    @Published var progressDrop: CGFloat = 0.1
    @Published var name = ""
    @Published var isShowingAddDrink: Bool = false
    var dailyWaterIntakeGoal: Double = 0
    @Published var todayWaterIntake: Double = 0
    @Published var currentGrowingPlant: Plant? {
        didSet {
            updateProgress()
        }
    }
    
    private func updateProgress() {
        guard let plant = currentGrowingPlant else { return }
        progress = CGFloat(plant.currentFillness) / CGFloat(plant.totalToGrow)
    }
}
