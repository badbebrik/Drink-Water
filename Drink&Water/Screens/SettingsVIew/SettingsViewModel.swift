//
//  SettingsViewModel.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var selectedLanguage: Language = .eng
    @Published var isDeleteAccountAlertPresented = false
    @Published var isResetAccountAlertPresented = false
    @Published var isShowingAboutPage = false

    
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
    
    func deleteAccount() {
        coreDataManager.deleteUser()
        coreDataManager.deleteAllDrinks()
        coreDataManager.deleteAllPlants()
    }
    
    func resetProgress() {
        coreDataManager.deleteAllDrinks()
        coreDataManager.deleteAllPlants()
        coreDataManager.updateTodayWaterIntake(0)
        coreDataManager.updateBalance(100)
    }
}
