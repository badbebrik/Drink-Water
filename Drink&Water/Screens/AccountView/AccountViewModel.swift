//
//  AccountViewModel.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import SwiftUI

class AccountViewModel: ObservableObject {
    @Published var height: Double = 0
    @Published var weight: Double = 0
    @Published var birthday: Date = Date.now
    @Published var image: UIImage? = nil
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var genderIndex = 0
    @Published var activity: String = ""
    @Published var isRefreshing = false
    
    let coreDataManager = CoreDataManager()

    
    func saveProfileImage(_ image: UIImage) {
            if let fileName = FileManagerService.shared.saveImageToFileSystem(image) {
                let coreDataManager = CoreDataManager()
                coreDataManager.updateUserProfileImagePath(fileName)
                self.image = FileManagerService.shared.loadImageFromFileSystem(fileName: fileName)
            }
        }
    
    func fetchData() {
        if let userData = coreDataManager.getUserData() {
            firstName = userData.name ?? ""
            lastName = userData.lastName ?? ""
            height = userData.height
            weight = userData.weight
            genderIndex = Int(userData.gender)
            activity = userData.activity ?? "Low"
            birthday = userData.birthday!
            
            if let profileImagePath = userData.profileImagePath {
                        image = FileManagerService.shared.loadImageFromFileSystem(fileName: profileImagePath)
                    }
        }
    }
    
    func updateUser() {
        coreDataManager.updateUser(name: firstName, lastName: lastName, gender: genderIndex, weight: weight, height: height, birthday: birthday, activity: activity, todayWaterIntake: 0, balance: 100)
    }

}

