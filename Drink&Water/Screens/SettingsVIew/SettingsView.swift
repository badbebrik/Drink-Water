//
//  SettingsView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel = SettingsViewModel()
    
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
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                Form {
                    Section(header: Text("Language")) {
                        Picker("Language", selection: $viewModel.selectedLanguage) {
                            ForEach(Language.allCases, id: \.self) { language in
                                HStack {
                                    Text(language.rawValue).tag(language)
                                }
                            }
                        }
                        Button("Save Language Selection") {
                            viewModel.saveLanguageSelection(language: viewModel.selectedLanguage)
                            viewModel.showRestartAlert = true
                                }
                        .alert(isPresented: $viewModel.showRestartAlert) {
                                    Alert(
                                        title: Text("Restart Required"),
                                        message: Text("Please restart the app to apply the language change."),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                    }
                    
                    Section(header: Text("Notifications")) {
                        
                        List {
                            ForEach(viewModel.notifications, id: \.id) { notification in
                                NotificationCell(notification: notification, onDelete: { id in
                                    viewModel.coreDataManager.deleteNotification(id: id)
                                    viewModel.fetchNotifications()
                                })
                            }
                            
                            Button(action: {
                                viewModel.showingAddNotificationView = true
                                NotificationManager.shared.requestAuthorization()
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add Notification")
                                }
                            }
                            .foregroundColor(.blue)
                        }
                        .onAppear {
                            viewModel.fetchNotifications()
                        }
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
                                viewModel.isShowingContentView = true
                                
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
                    }
                }
                
                
            }
        }
        .onAppear() {
            let languageCode = UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"
            viewModel.selectedLanguage = Language(rawValue: languageCode) ?? .eng
        }
        .disabled(viewModel.showingAddNotificationView || viewModel.isShowingAboutPage)
        .blur(radius: viewModel.showingAddNotificationView || viewModel.isShowingAboutPage ? 3 : 0)
        
        .overlay() {
            viewModel.isShowingAboutPage ? AboutView(settingsViewModel: viewModel).transition(.opacity) : nil
            
        }
        .animation(.easeInOut, value: viewModel.isShowingAboutPage)
        .overlay() {
            viewModel.showingAddNotificationView ? AddNotificationView(settingsViewModel: viewModel).transition(.opacity) : nil
        }
        .animation(.easeInOut, value: viewModel.showingAddNotificationView)
        .fullScreenCover(isPresented: $viewModel.isShowingContentView) {
            ContentView()
        }
    }
    
}


#Preview {
    SettingsView()
}
