//
//  AddDrinkButtonView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI

struct AddDrinkButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.title)
            .padding(10)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(radius: 5)
    }
}

#Preview {
    Image(systemName: "plus")
        .modifier(AddDrinkButton())
}
