//
//  MaskedImageModifier.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 15.03.2024.
//

import SwiftUI

struct MaskedImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .mask(
                Image(systemName: "drop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(x: 1.1, y: 1)
                    .padding(20)
            )
    }
}
