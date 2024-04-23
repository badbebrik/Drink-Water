//
//  AddNotificationView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 28.03.2024.
//

import SwiftUI

struct AddNotificationView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    @State private var selectedTime = Date()
    @State private var notificationText = ""
    
    var body: some View {
        VStack {
            
            Text("Select Time")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .top], 16)
            HStack {
                Spacer()
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                Spacer()
            }
        
            TextField("Notification Text", text: $notificationText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: selectedTime)
                let minute = calendar.component(.minute, from: selectedTime)
                let identifier = UUID().uuidString
                
                NotificationManager.shared.requestAuthorization()
                
                NotificationManager.shared.scheduleDailyNotification(hour: hour, minute: minute, identifier: identifier, body: notificationText)
                
                let notification = NotificationModel(id: UUID(), hour: hour, minute: minute, text: notificationText)
                settingsViewModel.coreDataManager.saveNotification(notificationModel: notification)
                settingsViewModel.fetchNotifications()
                settingsViewModel.showingAddNotificationView = false
            }
            .padding()
        }
        .overlay(
            Button(action: {
                settingsViewModel.showingAddNotificationView = false
            }) {
                Image(systemName: "xmark")
                    .padding()
            },
            alignment: .topTrailing
        )
        .background(.white)
        .padding()
    }
}


#Preview {
    AddNotificationView(settingsViewModel: SettingsViewModel())
}
