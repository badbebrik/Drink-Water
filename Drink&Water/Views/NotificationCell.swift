//
//  NotificationCell.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 02.04.2024.
//

import SwiftUI

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
