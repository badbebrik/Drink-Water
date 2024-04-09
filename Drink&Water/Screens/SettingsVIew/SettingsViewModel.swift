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
    @Published var notifications: [NotificationModel] = []
    @Published var isShowingContentView = false
    @Published var showingAddNotificationView = false
    @Published var showRestartAlert = false

    let coreDataManager = CoreDataManager()
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    
    func deleteAccount() {
        coreDataManager.deleteUser()
        coreDataManager.deleteAllDrinks()
        coreDataManager.deleteAllPlants()
        coreDataManager.deleteAllNotifications()
        coreDataManager.isTodayGoalCompleted = false
        coreDataManager.lastUpdate = nil
        print(coreDataManager.lastUpdate)
    }
    
    func resetProgress() {
        coreDataManager.deleteAllDrinks()
        coreDataManager.deleteAllPlants()
        coreDataManager.updateTodayWaterIntake(0)
        coreDataManager.updateBalance(100)
        coreDataManager.isTodayGoalCompleted = false
        coreDataManager.lastUpdate = nil
    }
    
    func fetchNotifications() {
        notifications = coreDataManager.getAllNotifications()
    }
    
    func saveLanguageSelection(language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: "SelectedLanguage")
            showRestartAlert = true
        }
    
}
