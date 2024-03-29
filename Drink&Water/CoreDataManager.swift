//
//  CoreDataManager.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 12.03.2024.
//

import Foundation
import CoreData
import UserNotifications

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
    
    func saveUser(name: String, lastName: String, gender: Int, weight: Double, height: Double, birthday: Date, activity: String, balance: Int32) {
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
        user.balance = balance
        
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
    
    func updateUser(name: String, lastName: String, gender: Int, weight: Double, height: Double, birthday: Date, activity: String, todayWaterIntake: Double, balance: Int32) {
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
        user.balance = balance
        
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
        drinkToAdd.id = drink.id
        
        
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
                let drink = Drink(id: entity.id ?? UUID(),
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

extension CoreDataManager {
    func savePlant(name: String, totalToGrow: Int, price: Int, startGrowDate: Date, currentFillness: Int, finishGrowDate: Date) {
        let managedContext = persistentContainer.viewContext
        
        let plantToAdd = PlantEntity(context: managedContext)
        plantToAdd.name = name
        plantToAdd.totalToGrow = Int32(totalToGrow)
        plantToAdd.price = Int32(price)
        plantToAdd.startGrowDate = startGrowDate
        plantToAdd.currentFillness = Int32(currentFillness)
        plantToAdd.finishGrowDate = finishGrowDate
        
        do {
            try managedContext.save()
        } catch {
            print("Failed to save plant: \(error)")
        }
    }
    
    func getAllPlants() -> [Plant]? {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<PlantEntity> = PlantEntity.fetchRequest()
        
        do {
            let plantEntities = try managedContext.fetch(fetchRequest)
            var plants: [Plant] = []
            for entity in plantEntities {
                let plant = Plant(id: UUID(), name: entity.name ?? "",
                                  totalToGrow: Int(entity.totalToGrow),
                                  price: Int(entity.price),
                                  startGrowDate: entity.startGrowDate ?? Date(),
                                  currentFillness: Int(entity.currentFillness),
                                  finishGrowDate: entity.finishGrowDate ?? Date())
                plants.append(plant)
            }
            return plants
        } catch {
            print("Failed to fetch plants: \(error)")
            return nil
        }
    }
    
    func deleteAllPlants() {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PlantEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch {
            print("Failed to delete plants: \(error)")
        }
    }
    
    
    func updateFirstPlantCurrentFillness(newFillness: Int) {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<PlantEntity> = PlantEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "currentFillness < totalToGrow")
        fetchRequest.fetchLimit = 1
        
        do {
            let plants = try managedContext.fetch(fetchRequest)
            if let plant = plants.first {
                plant.currentFillness = Int32(newFillness)
                try managedContext.save()
            } else {
                print("No plant found with current fillness less than total to grow")
            }
        } catch {
            print("Failed to update plant current fillness: \(error)")
        }
    }
    
    func updateUserProfileImagePath(_ fileName: String) {
        let managedContext = persistentContainer.viewContext
        
        if let user = getUserData() {
            if let oldFileName = user.profileImagePath, !oldFileName.isEmpty {
                FileManagerService.shared.deleteImageFromFileSystem(fileName: oldFileName)
            }
            
            user.profileImagePath = fileName
            
            do {
                try managedContext.save()
                print("Successfully updated user profile image path.")
            } catch {
                print("Failed to update user profile image path: \(error)")
            }
        } else {
            print("User not found")
        }
    }
    
    func deleteDrink(id: UUID) {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DrinkEntity> = DrinkEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let drinks = try managedContext.fetch(fetchRequest)
            if let drinkToDelete = drinks.first {
                managedContext.delete(drinkToDelete)
                try managedContext.save()
            }
        } catch {
            print("Failed to delete drink: \(error)")
        }
    }
    
    func updateBalance(_ newBalance: Int32) {
        let managedContext = persistentContainer.viewContext
        if let user = getUserData() {
            user.balance = newBalance
            
            do {
                try managedContext.save()
                print("Successfully updated user profile image path.")
            } catch {
                print("Failed to update user profile image path: \(error)")
            }
        }
        
    }
    
    func getAllNotifications() -> [NotificationModel] {
        let fetchRequest: NSFetchRequest<NotificationEntity> = NotificationEntity.fetchRequest()
        do {
            let notificationEntities = try persistentContainer.viewContext.fetch(fetchRequest)
            return notificationEntities.map { entity in
                
                return NotificationModel(id: entity.id!, hour: Int(entity.hour), minute: Int(entity.minute), text: entity.text!)
            }
        } catch let error as NSError {
            print("Не удалось получить данные \(error), \(error.userInfo)")
            return []
        }
    }
    
    func saveNotification(notificationModel: NotificationModel) {
        let context = persistentContainer.viewContext
        let notificationEntity = NotificationEntity(context: context)
        
        notificationEntity.id = notificationModel.id
        notificationEntity.hour = Int32(notificationModel.hour)
        notificationEntity.minute = Int32(notificationModel.minute)
        notificationEntity.text = notificationModel.text
        
        do {
            try context.save()
            print("Уведомление успешно сохранено.")
        } catch {
            print("Ошибка при сохранении уведомления: \(error.localizedDescription)")
        }
    }
    
    func deleteNotification(id: UUID) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NotificationEntity> = NotificationEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let notificationToDelete = results.first {
                context.delete(notificationToDelete)
                NotificationManager.shared.removeNotification(id: id)
                try context.save()
                print("Уведомление успешно удалено.")
            }
        } catch {
            print("Ошибка при удалении уведомления: \(error.localizedDescription)")
        }
    }
    
    func deleteAllNotifications() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NotificationEntity.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            try context.execute(deleteRequest)
            print("Все уведомления успешно удалены.")
        } catch {
            print("Ошибка при удалении всех уведомлений: \(error.localizedDescription)")
        }
    }
    
}
