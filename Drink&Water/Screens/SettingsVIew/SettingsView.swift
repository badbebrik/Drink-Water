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
    @State private var isShowingAboutPage: Bool = false
    @State private var isDeleteAccountButtonTapped = false
    @State private var isDeleteAccountAlertPresented = false
    @State private var isResetAccountAlertPresented = false
    
    
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
//                    Section(header: Text("App Theme")) {
//                        Picker("Theme", selection: $selectedTheme) {
//                            ForEach(Theme.allCases, id: \.self) { theme in
//                                Text(theme.rawValue).tag(theme)
//                            }
//                        }
//                        .pickerStyle(SegmentedPickerStyle())
//                        .padding()
//                    }
                    
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
                        ForEach(["There will be added Notifications soon"], id: \.self) { elem in
                            
                            
                            Text(elem)
                        }
                    }
                    
                    Section(header: Text("Account")) {
                        Button(action: {
                            isDeleteAccountAlertPresented = true
                        }) {
                            Text("Delete account")
                                .foregroundStyle(.red)
                        }
                        .alert(isPresented: $isDeleteAccountAlertPresented) {
                            Alert(title: Text("Are you sure?"),
                                  message: Text("Deleting your account will erase all your data. This action cannot be undone."),
                                  primaryButton: .cancel(Text("Cancel")),
                                  secondaryButton: .destructive(Text("Delete"), action: {
                                let coreDataManager = CoreDataManager()
                                coreDataManager.deleteUser()
                                coreDataManager.deleteAllDrinks()
                                coreDataManager.deleteAllPlants()
                                isDeleteAccountButtonTapped = true
                                
                            }))
                        }
                        
                        Button(action: {
                            isResetAccountAlertPresented = true
                        }) {
                            Text("Reset Progress")
                                .foregroundStyle(.red)
                        }
                        .alert(isPresented: $isResetAccountAlertPresented) {
                            Alert(title: Text("Are you sure?"),
                                  message: Text("Resetting your progress will empty your plants gallary and water intake activity."),
                                  primaryButton: .cancel(Text("Cancel")),
                                  secondaryButton: .destructive(Text("Reset progress"), action: {
                                let coreDataManager = CoreDataManager()
                                coreDataManager.deleteAllDrinks()
                                coreDataManager.deleteAllPlants()
                                coreDataManager.updateTodayWaterIntake(0)
                                
                            }))
                        }
                        
                    }
                    
                    Section(header: Text("Developer")) {
                        Button() {
                            isShowingAboutPage = true
                        } label: {
                            Text("About")
                        }
                        .sheet(isPresented: $isShowingAboutPage, content: {
                            AboutView()
                        })
                        
                    }
                }
                
            }
            
            
        }
        .fullScreenCover(isPresented: $isDeleteAccountButtonTapped) {
            ContentView()
        }
        
    }
    
}


#Preview {
    SettingsView()
}
