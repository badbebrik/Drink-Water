//
//  OnboardingViewModel.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: Int = 0
    @Published var onboardingFinished = false
    
    let onboardingSteps: [OnboardingStep]
    
    init() {
        self.onboardingSteps = [
            OnboardingStep(imageBackground: "Vector", imageForeground: "drinkingHuman", title: "Track your daily water intake with Us.", description: "Achieve your hydration goals \nwith a simple tap!", backgroundImageHeight: 300, backgroundImageWidth: 265, foregroundImageHeight: 300, foregroundImageWidth: 310),
            OnboardingStep(imageBackground: "curveForm", imageForeground: "plants", title: "Keep motivation with \nplants growing gamification ", description: "Drink water and water the plants!\nHow many plants can you grow?", backgroundImageHeight: 310, backgroundImageWidth: 280, foregroundImageHeight: 200, foregroundImageWidth: 200),
            OnboardingStep(imageBackground: "curveForm", imageForeground: "bell", title: "Custom remainders", description: "Quick and easy to set your hydration goal \nand then track your daily \nwater intake progress.", backgroundImageHeight: 300, backgroundImageWidth: 265, foregroundImageHeight: 200, foregroundImageWidth: 200)
        ]
    }
    
    func nextStep() {
        currentStep += 1
        if currentStep >= onboardingSteps.count {
            onboardingFinished = true
        }
    }
}
