//
//  NotificationModel.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 28.03.2024.
//

import Foundation

struct NotificationModel: Identifiable {
    var id: UUID
    var hour: Int
    var minute: Int
    var text: String
}
