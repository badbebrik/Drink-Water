//
//  TrackerView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI

struct TrackerView: View {
    
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    
    @State var name = "Bob"
    @State var arr = ["Water", "Juice", "Milk"]
    @State private var numbers = [1,2,3,4,5,6,7,8,9]
    let colors: [Color] = [.red, .green, .blue]
    
    
    var body: some View {
        ZStack {
            Color("BrandBlue")
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack(spacing: 20) {
                        Text("Tracker")
                            .font(.system(size: 32, weight: .black))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .frame(width: 353, height: 26, alignment: .leading)
                        
                        Text("Good Morning, \(name)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.leading)
                            .frame(width: 353, height: 26, alignment: .leading)
                        
                        Text("Today Goal:")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.leading)
                            .frame(width: 353, height: 26, alignment: .leading)
                    }
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 352, height: 288)
                            .background(.white)
                            .cornerRadius(30)
                            .shadow(color: Color(.black)
                                .opacity(0.25), radius: 2, x: 0, y: 4)
                        VStack {
                            Text("1500/3000 ml")
                                .foregroundStyle(.black)
                            GeometryReader { proxy in
                                
                                let size = proxy.size
                                
                                ZStack {
                                    Image(systemName: "drop.fill")
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundStyle(.brandBlue)
                                        .scaleEffect(x: 1.1, y: 1)
                                        .offset(y: -1)
                                    
                                    WaterWave(progress: 0.5, waveHeight: 0.1, offset: startAnimation)
                                        .fill(Color(.blue))
                                        .mask {
                                            Image(systemName: "drop.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .scaleEffect(x: 1.1, y: 1)
                                                .padding(20)
                                        }
                                        .overlay {
                                            ZStack {
                                                Circle()
                                                    .fill(.brandBlue.opacity(0.1))
                                                    .frame(width: 15, height: 15)
                                                    .offset(x: -20)
                                                
                                                Circle()
                                                    .fill(.brandBlue.opacity(0.1))
                                                    .frame(width: 15, height: 15)
                                                    .offset(x: 40, y: 30)
                                                
                                                Circle()
                                                    .fill(.brandBlue.opacity(0.1))
                                                    .frame(width: 25, height: 25)
                                                    .offset(x: -30, y: 80)
                                                
                                                Circle()
                                                    .fill(.brandBlue.opacity(0.1))
                                                    .frame(width: 25, height: 25)
                                                    .offset(x: 50, y: 70)
                                                
                                                Circle()
                                                    .fill(.brandBlue.opacity(0.1))
                                                    .frame(width: 10, height: 10)
                                                    .offset(x: 40, y: 100)
                                                
                                                Circle()
                                                    .fill(.brandBlue.opacity(0.1))
                                                    .frame(width: 10, height: 10)
                                                    .offset(x: -40, y: 50)
                                            }
                                        }
                                }
                                .frame(width: size.width, height: size.height, alignment: .center)
                                .onAppear {
                                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)){
                                        startAnimation = size.width
                                    }
                                }
                                
                            }
                            .frame(height: 240)
                            
                        }
                        
                        AddDrinkButtonView()
                            .padding(.top, 200)
                            .padding(.leading, 150)
                        
                    }
                    
                    Text("Your Plant:")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                        .frame(width: 353, height: 26, alignment: .leading)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 352, height: 167)
                            .background(.white)
                            .cornerRadius(30)
                        
                        HStack(spacing: 50) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 100, height: 100)
                                .background(
                                    Image("sunflower")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                )
                            
                            CircularProgressView(progress: 0.8)
                                .frame(width: 100)
                        }
                    }
                    
                    Text("Today's records:")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                        .frame(width: 353, height: 26, alignment: .leading)
                    
                    VStack {
                        List {
                            ForEach(self.numbers, id: \.self) {
                                Text("\($0)")
                            }
                            .onDelete { index in
                                // delete item
                            }
                        }.frame(width: 350, height: 150, alignment: .center)
                            .listStyle(.plain)
                            .cornerRadius(30, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    }
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 352, height: 288)
                            .background(.white)
                            .cornerRadius(30)
                            .shadow(color: Color(.black)
                                .opacity(0.25), radius: 2, x: 0, y: 4)
                        
                        VStack(spacing: 40) {
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: 320, height: 1)
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: 320, height: 1)
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: 320, height: 1)
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: 320, height: 1)
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: 320, height: 1)
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: 320, height: 1)
                        }
                    }
                    
                    
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 352, height: 20)
                        .background(.clear)
                        .cornerRadius(30)
                        .shadow(color: Color(.black)
                            .opacity(0.25), radius: 2, x: 0, y: 4)
                    
                    
                    
                    
                }
            }
        }
    }
    
}



struct WaterWave: Shape {
    var progress: CGFloat
    
    var waveHeight: CGFloat
    
    var offset: CGFloat
    
    var animatableData: CGFloat {
        get {offset}
        set {offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: .zero)
            
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2) {
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: (value + offset)).radians)
                let y: CGFloat = progressHeight + (height * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
        }
    }
}




#Preview {
    TrackerView()
}


struct CircularProgressView: View {
    // 1
    let progress: Double
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.blue.opacity(0.5),
                    lineWidth: 15
                )
            
            Text("500 ml until next stage")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .frame(width: 66, height: 72, alignment: .center)
            
            Circle()
            // 2
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
