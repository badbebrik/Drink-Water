//
//  CircularProgressView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 13.03.2024.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.blue.opacity(0.5),
                    lineWidth: 15
                )
            
            Text("\(Int(progress * 100))%")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .frame(width: 66, height: 72, alignment: .center)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(
                        lineWidth: 15,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }
}


#Preview {
    CircularProgressView(progress: 0.5)
}
