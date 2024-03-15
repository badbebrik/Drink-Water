//
//  ShopViewModel.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import SwiftUI

class ShopViewModel: ObservableObject {
    
    @Published var plantsToBuy: [Plant] = [
        Plant(id: UUID(), name: "cactus", totalToGrow: 1200, price: 100, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()),
        Plant(id: UUID(), name: "red tulip", totalToGrow: 1200, price: 200, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()),
        Plant(id: UUID(), name: "purple tulip", totalToGrow: 1200, price: 300, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date()),
        Plant(id: UUID(), name: "apple", totalToGrow: 1200, price: 400, startGrowDate: Date(), currentFillness: 0, finishGrowDate: Date())
    ]
}
