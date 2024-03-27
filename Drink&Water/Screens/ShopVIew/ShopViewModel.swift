//
//  ShopViewModel.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import SwiftUI

class ShopViewModel: ObservableObject {
    @Published var balance: Int32 = 0
    
    @Published var plantsToBuy: [Plant] = [
        Plant(id: UUID(), name: "cactus", totalToGrow: 1200, price: 50, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()),
        Plant(id: UUID(), name: "red tulip", totalToGrow: 2500, price: 250, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()),
        Plant(id: UUID(), name: "purple tulip", totalToGrow: 3000, price: 500, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()),
        Plant(id: UUID(), name: "apple", totalToGrow: 5000, price: 1500, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date())
    ]
    
    func fetchBalance() -> Void {
        let coreDataManager = CoreDataManager()
        if let user = coreDataManager.getUserData() {
            balance = user.balance
        }
    }
}
