//
//  AppTheme.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import Foundation
import UIKit

enum Theme: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"
    
    var uiUserInterfaceStyle: UIUserInterfaceStyle? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}
