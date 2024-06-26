//
//  Drink.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 13.03.2024.
//

import Foundation

struct Drink: Hashable, Equatable  {
    let id: UUID
    let name: String
    let imageName: String
    var volume: Int
    let coefficient: Double
}
