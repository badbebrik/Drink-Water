//
//  NotificationManager.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 28.03.2024.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init () {}
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            print("Permission granted: \(granted)")
        }
    }
    
    
    func removeNotification(id: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        print("Notofication removed successfully")
    }
    
    func scheduleDailyNotification(hour: Int, minute: Int, identifier: String, title: String = "Drink&Water", body: String = "It's time!") {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling daily notification: \(error.localizedDescription)")
            }
        }
    }
    
}
