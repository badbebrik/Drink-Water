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

}

