//
//  LocalizationManager.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 02.04.2024.
//

import Foundation

class LocalizationManager {
    static let shared = LocalizationManager()

    private init() {}
    
    func localizeString(forKey key: String, value: String? = nil, language: String) -> String {
        let bundle = Bundle.forLanguage(language) ?? Bundle.main
        return NSLocalizedString(key, bundle: bundle, value: value ?? "", comment: "")
    }
    
}
