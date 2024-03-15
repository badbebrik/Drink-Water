//
//  CircleOverlayModifier.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import SwiftUI

struct CircleOverlayModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay(
            ZStack {
                Circle().fill(Color.brandBlue.opacity(0.1)).frame(width: 15, height: 15).offset(x: -20)
                Circle().fill(Color.brandBlue.opacity(0.1)).frame(width: 15, height: 15).offset(x: 40, y: 30)
                Circle().fill(Color.brandBlue.opacity(0.1)).frame(width: 25, height: 25).offset(x: -30, y: 80)
                Circle().fill(Color.brandBlue.opacity(0.1)).frame(width: 25, height: 25).offset(x: 50, y: 70)
                Circle().fill(Color.brandBlue.opacity(0.1)).frame(width: 10, height: 10).offset(x: 40, y: 100)
                Circle().fill(Color.brandBlue.opacity(0.1)).frame(width: 10, height: 10).offset(x: -40, y: 50)
            }
        )
    }
}
