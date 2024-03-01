//
//  AddDrinkButtonView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI

struct AddDrinkButtonView: View {
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Circle()
                    .frame(width: 65, height: 65)
                    .foregroundStyle(.white)
                    .shadow(color: Color(red: 0, green: 0, blue: 0).opacity(0.25), radius: 2, x: 0, y: 4)
                    .shadow(radius: 5)
                
                Image(systemName: "plus")
                    .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    AddDrinkButtonView()
}
