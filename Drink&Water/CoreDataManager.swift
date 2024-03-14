//
//  CoreDataManager.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 12.03.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Drink&Water")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func saveUser(name: String, lastName: String, gender: Int, weight: Double, height: Double, birthday: Date, activity: String) {
        let managedContext = persistentContainer.viewContext
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "UserModel", in: managedContext) else {
            print("Failed to find entity description")
            return
        }
        
        
        let dailyWaterIntake = DailyWaterIntakeCalculator.calculateDailyWaterIntake(weightInKg: weight, isFemale: gender, age: calculateAge(birthDate: birthday), activityLevel: activity)
        let user = UserModel(entity: entityDescription, insertInto: managedContext)
        user.name = name
        user.lastName = lastName
        user.gender = Int32(gender)
        user.weight = weight
        user.height = height
        user.birthday = birthday
        user.activity = activity
        user.dailyWaterIntake = dailyWaterIntake
        user.todayWaterIntake = 0
        
        do {
            try managedContext.save()
        } catch {
            print("Failed to save user: \(error)")
        }
    }
    
    func getUserData() -> UserModel? {
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        
        do {
            let users = try managedContext.fetch(fetchRequest)
            return users.first
        } catch {
            print("Failed to fetch user: \(error)")
            return nil
        }
    }
    
    
    func isUserRegistered() -> Bool {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        
        do {
            let users = try managedContext.fetch(fetchRequest)
            return !users.isEmpty
        } catch {
            print("Failed to fetch user: \(error)")
            return false
        }
    }
    
    func deleteUser() {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserModel")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch {
            print("Failed to delete users: \(error)")
        }
    }
    
    func updateUser(name: String, lastName: String, gender: Int, weight: Double, height: Double, birthday: Date, activity: String, todayWaterIntake: Double) {
        guard let user = getUserData() else {
            print("User not found")
            return
        }
        
        let dailyWaterIntake = DailyWaterIntakeCalculator.calculateDailyWaterIntake(weightInKg: weight, isFemale: gender, age: calculateAge(birthDate: birthday), activityLevel: activity)
        
        user.name = name
        user.lastName = lastName
        user.gender = Int32(gender)
        user.weight = weight
        user.height = height
        user.birthday = birthday
        user.activity = activity
        user.dailyWaterIntake = dailyWaterIntake
        user.todayWaterIntake = todayWaterIntake
        
        do {
            try user.managedObjectContext?.save()
        } catch {
            print("Failed to update user: \(error)")
        }
    }
    
    func calculateAge(birthDate: Date) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate)
        let age = ageComponents.year ?? 0
        return age
    }
    
    func updateTodayWaterIntake(_ todayWaterIntake: Double) {
        guard let user = getUserData() else {
            print("User not found")
            return
        }

        user.todayWaterIntake = todayWaterIntake

        do {
            try user.managedObjectContext?.save()
        } catch {
            print("Failed to update today's water intake: \(error)")
        }
    }
    
    
    func saveDrink(_ drink: Drink) {
        let managedContext = persistentContainer.viewContext
        
        let drinkToAdd = DrinkEntity(context: managedContext)
        drinkToAdd.name = drink.name
        drinkToAdd.volume = Int32(drink.volume)
        drinkToAdd.imageName = drink.imageName
        
        do {
            try managedContext.save()
        } catch {
            print("Failed to save drink: \(error)")
        }
    }

    func getAllDrinks() -> [Drink]? {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DrinkEntity> = DrinkEntity.fetchRequest()

        do {
            let drinkEntities = try managedContext.fetch(fetchRequest)
                    var drinks: [Drink] = []
                    for entity in drinkEntities {
                        let drink = Drink(id: UUID(),
                                          name: entity.name ?? "",
                                          imageName: entity.imageName ?? "",
                                          volume: Int(entity.volume))
                        drinks.append(drink)
                    }
                    return drinks
        } catch {
            print("Failed to fetch drinks: \(error)")
            return nil
        }
    }
    
    
    func deleteAllDrinks() {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "DrinkEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(deleteRequest)
        } catch {
            print("Failed to delete drinks: \(error)")
        }
    }
    
}
