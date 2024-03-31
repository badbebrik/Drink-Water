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
    var dailyWaterIntakeGoal: Double = 0
    @Published var todayWaterIntake: Double = 0
    @Published var isAnimating: Bool = false
    @Published var drinkToDelete: Drink?
    @Published var todayDrinks: [Drink] = []
    
    func localizedString(forKey key: String, value: String? = nil, language: String) -> String {
        let bundle = Bundle.forLanguage(language) ?? Bundle.main
        return NSLocalizedString(key, bundle: bundle, value: value ?? "", comment: "")
    }
    
    
    private let lastUpdateKey = "lastUpdate"
    private var lastUpdate: Date? {
        get {
            UserDefaults.standard.object(forKey: lastUpdateKey) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: lastUpdateKey)
        }
    }
    
    init() {
        lastUpdate = Date()
        checkForDailyReset()
    }
    
    func checkForDailyReset() {
        let calendar = Calendar.current
        if var lastUpdate = lastUpdate, !calendar.isDateInToday(lastUpdate) {
            todayWaterIntake = 0
            let coreDataManager = CoreDataManager()
            coreDataManager.deleteAllDrinks()
            coreDataManager.updateTodayWaterIntake(0)
            lastUpdate = Date()
        } else if lastUpdate == nil {
            lastUpdate = Date()
        }
    }
    
    
    @Published var currentGrowingPlant: Plant? {
        didSet {
            updateProgress()
        }
    }
    
    
    private func updateProgress() {
        guard let plant = currentGrowingPlant else { return }
        progress = CGFloat(plant.currentFillness) / CGFloat(plant.totalToGrow)
    }
    
    
    func fetchData() {
        let coreDataManager = CoreDataManager()
        let user = coreDataManager.getUserData()
        name = user?.name ?? ""
        todayDrinks = coreDataManager.getAllDrinks() ?? []
        if let plants = coreDataManager.getAllPlants() {
            let firstPlant = plants.last
            currentGrowingPlant = firstPlant
        }
        
        todayWaterIntake = user?.todayWaterIntake ?? 0
        dailyWaterIntakeGoal = user?.dailyWaterIntake ?? 3000
        progressDrop = todayWaterIntake / dailyWaterIntakeGoal
    }
    
    func checkStage(plant: Plant) -> String {
        
        switch (Double(plant.currentFillness) / Double(plant.totalToGrow)) {
        case 0...0.25:
            return "seed"
        case 0.26...0.70:
            return "sprout"
        case 0.71...0.99:
            return "teen"
        default:
            return "adult"
        }
    }
    

    func greetingBasedOnTime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12:
            return localizedString(forKey: "Good Morning", language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en") + ", \(name)"
        case 12..<17:
            return localizedString(forKey: "Good Afternoon", language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en") + ", \(name)"
        case 17..<22:
            return localizedString(forKey: "Good Evening", language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en") + ", \(name)"
        default:
            return localizedString(forKey: "Good Night", language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en") + ", \(name)"
        }
    }
}
