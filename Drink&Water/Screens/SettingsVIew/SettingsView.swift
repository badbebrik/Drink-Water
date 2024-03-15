//
//  SettingsView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel = SettingsViewModel()
    @State private var isShowingContentView = false
    
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
                    Section(header: Text("Language")) {
                        Picker("Language", selection: $viewModel.selectedLanguage) {
                            ForEach(Language.allCases, id: \.self) { language in
                                HStack {
                                    Text(language.rawValue).tag(language)
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Notifications")) {
                        Text("There will be added Notifications soon")
                    }
                    
                    Section(header: Text("Account")) {
                        Button(action: {
                            viewModel.isDeleteAccountAlertPresented = true
                        }) {
                            Text("Delete account")
                                .foregroundStyle(.red)
                        }
                        .alert(isPresented: $viewModel.isDeleteAccountAlertPresented) {
                            Alert(title: Text("Are you sure?"),
                                  message: Text("Deleting your account will erase all your data. This action cannot be undone."),
                                  primaryButton: .cancel(Text("Cancel")),
                                  secondaryButton: .destructive(Text("Delete"), action: {
                                    viewModel.deleteAccount()
                                    isShowingContentView = true
                                    
                            }))
                        }
                        
                        Button(action: {
                            viewModel.isResetAccountAlertPresented = true
                        }) {
                            Text("Reset Progress")
                                .foregroundStyle(.red)
                        }
                        .alert(isPresented: $viewModel.isResetAccountAlertPresented) {
                            Alert(title: Text("Are you sure?"),
                                  message: Text("Resetting your progress will empty your plants gallery and water intake activity."),
                                  primaryButton: .cancel(Text("Cancel")),
                                  secondaryButton: .destructive(Text("Reset progress"), action: {
                                    viewModel.resetProgress()
                            }))
                        }
                    }
                    
                    Section(header: Text("Developer")) {
                        Button(action: {
                            viewModel.isShowingAboutPage = true
                        }) {
                            Text("About")
                        }
                        .sheet(isPresented: $viewModel.isShowingAboutPage) {
                            AboutView()
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isShowingContentView) {
                    ContentView()
                }
    }
}


#Preview {
    SettingsView()
}
