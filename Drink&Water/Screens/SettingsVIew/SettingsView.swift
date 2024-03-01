//
//  SettingsView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI


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


enum Language: String, CaseIterable {
    case ru = "🇷🇺Russian"
    case eng = "🇺🇸English"
}

struct SettingsView: View {
    
    @State private var selectedTheme: Theme = .system
    @State private var selectedLanguage: Language = .eng
    @State private var selectedDate: Date = Date()
    
    
    var body: some View {
        ZStack {
            Color(.brandBlue)
                .ignoresSafeArea()
            
            
            VStack {
                Text("Settings")
                    .font(.system(size: 32, weight: .black))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .frame(width: 353, height: 26, alignment: .leading)
                
                Form {
                    Section(header: Text("App Theme")) {
                        Picker("Theme", selection: $selectedTheme) {
                            ForEach(Theme.allCases, id: \.self) { theme in
                                Text(theme.rawValue).tag(theme)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    }
                    
                    Section(header: Text("Language")) {
                        Picker("Language", selection: $selectedLanguage) {
                            ForEach(Language.allCases, id: \.self) { language in
                                HStack {
                                    Text(language.rawValue).tag(language)
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Notifications")) {
                        ForEach(["Test Notification", "Test Notification", "Test Notification"], id: \.self) { elem in
                            
                            
                            Text(elem)
                        }
                    }
                }
                
            }
            
            
        }
        
    }
    
}


#Preview {
    SettingsView()
}
