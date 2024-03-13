//
//  DrinkAddView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 13.03.2024.
//

import SwiftUI

struct DrinkAddView: View {
    
    let drinks: [Drink] = [
        Drink(id: UUID(), name: "Water", imageName: "water 2"),
        Drink(id: UUID(), name: "Coffee", imageName: "coffee"),
        Drink(id: UUID(), name: "Tea", imageName: "tea"),
        
    ]
    
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        
        VStack {
            Text("Choose The Drink")
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(150))]) {
                    ForEach(drinks, id: \.id) { drink in
                        VStack {
                            Image(drink.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            Text(drink.name)
                                .font(.caption)
                        }
                        .padding()
                    }
                }
                .padding()
            }
        }
        .frame(width: 300, height: 525)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(Button {
            isShowingDetail = false
        } label: {
            Text("back")
                .padding()
            
    }, alignment: .topTrailing)
    }
    
}



#Preview {
    DrinkAddView(isShowingDetail: .constant(true))
}
