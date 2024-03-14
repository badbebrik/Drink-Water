//
//  DailyWaterIntakeHandler.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 14.03.2024.
//

import Foundation

class DailyWaterIntakeCalculator {
    
    static func calculateDailyWaterIntake(weightInKg: Double, isFemale: Int, age: Int, activityLevel: String) -> Double {
        var baseWaterIntake: Double = 0.0
        
        // Учет пола
        baseWaterIntake = isFemale == 1 ? weightInKg * 31 : weightInKg * 35
        
        // Учет возраста
        if age < 30 {
            baseWaterIntake *= 1.0
        } else if age < 55 {
            baseWaterIntake *= 0.95
        } else {
            baseWaterIntake *= 0.85
        }
        
        // Учет уровня активности
        var activityMultiplier: Double = 0.0
        switch activityLevel {
        case "Low":
            activityMultiplier = 1.0
        case "Medium":
            activityMultiplier = 1.1
        case "High":
            activityMultiplier = 1.35
        default:
            activityMultiplier = 1.0
        }
        
        let dailyWaterIntake = baseWaterIntake * activityMultiplier
        
        return dailyWaterIntake
    }
}
