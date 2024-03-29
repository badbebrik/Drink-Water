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
