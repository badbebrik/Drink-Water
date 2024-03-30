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
    @State private var showingAddNotificationView = false
    @State private var showRestartAlert = false
    
    func saveLanguageSelection(language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: "SelectedLanguage")
            showRestartAlert = true
        }
    
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
                        Button("Сохранить выбор языка") {
                            saveLanguageSelection(language: viewModel.selectedLanguage)
                                    showRestartAlert = true
                                }
                                .alert(isPresented: $showRestartAlert) {
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
                                showingAddNotificationView = true
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add Notification")
                                }
                            }
                            .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $showingAddNotificationView) {
                            AddNotificationView(viewModel: viewModel)
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
        .onAppear() {
            let languageCode = UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"
            viewModel.selectedLanguage = Language(rawValue: languageCode) ?? .eng
        }
        .fullScreenCover(isPresented: $isShowingContentView) {
            ContentView()
        }
    }
    
}



struct NotificationCell: View {
    var notification: NotificationModel
    var onDelete: (UUID) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(notification.text)
                    .font(.headline)
                Text("\(notification.hour):\(notification.minute)")
                    .font(.caption)
                
            }
            
            Spacer()
            
            Button(action: { self.onDelete(notification.id) }) {
                Image(systemName: "xmark.circle")
                    .foregroundColor(.red)
            }
            
        }
        .padding()
    }
    
}




private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()



#Preview {
    SettingsView()
}
