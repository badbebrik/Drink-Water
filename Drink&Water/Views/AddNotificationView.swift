//
//  AddNotificationView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 28.03.2024.
//

import SwiftUI

struct AddNotificationView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTime = Date()
    @State private var notificationText = ""
    
    var body: some View {
        VStack {
            Text("Select Time")
                .padding()
            DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
            
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
                viewModel.coreDataManager.saveNotification(notificationModel: notification)
                viewModel.fetchNotifications()
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .background(.white)
        .padding()
    }
}


#Preview {
    AddNotificationView(viewModel: SettingsViewModel())
}
