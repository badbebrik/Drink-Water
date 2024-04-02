//
//  HealthKitManager.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 29.03.2024.
//

import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()

    private init() {}
    
    let healthStore = HKHealthStore()

    func requestHealthKitAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit не доступен на этом устройстве.")
            return
        }
        
        let typesToShare: Set = [
            HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: Set()) { (success, error) in
            if !success || error != nil {
                print("Ошибка при запросе разрешения HealthKit: \(String(describing: error))")
            }
        }
    }
    
    
    func addDrinkToHealthKit(volume: Double, coefficient: Double) {
        guard let waterType = HKQuantityType.quantityType(forIdentifier: .dietaryWater) else {
            print("Тип воды не доступен.")
            return
        }
        
        let waterQuantity = HKQuantity(unit: HKUnit.literUnit(with: .milli), doubleValue: volume * coefficient)
        let now = Date()
        let sample = HKQuantitySample(type: waterType, quantity: waterQuantity, start: now, end: now)
        
        healthStore.save(sample) { (success, error) in
            if !success {
                print("Ошибка при сохранении напитка в HealthKit: \(String(describing: error))")
            } else {
                print("Напиток успешно сохранён в HealthKit.")
            }
        }
    }
}
