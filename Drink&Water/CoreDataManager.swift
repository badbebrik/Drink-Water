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
        
        let user = UserModel(entity: entityDescription, insertInto: managedContext)
        user.name = name
        user.lastName = lastName
        user.gender = Int32(gender)
        user.weight = weight
        user.height = height
        user.birthday = birthday
        user.activity = activity
        
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
    
    func updateUser(name: String, lastName: String, gender: Int, weight: Double, height: Double, birthday: Date) {
        guard let user = getUserData() else {
            print("User not found")
            return
        }
        
        user.name = name
        user.lastName = lastName
        user.gender = Int32(gender)
        user.weight = weight
        user.height = height
        user.birthday = birthday
        
        do {
            try user.managedObjectContext?.save()
        } catch {
            print("Failed to update user: \(error)")
        }
    }
    
}