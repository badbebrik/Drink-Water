//
//  Plant.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 28.02.2024.
//

import Foundation

struct Plant: Identifiable {
    var id: UUID
    var name: String
    var totalToGrow: Int
    var price: Int
    var startGrowDate: Date
    var currentFillness: Int
    var finishGrowDate: Date
}
