//
//  TrackerView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI


class TrackerViewModel: ObservableObject {
    @Published var progress: CGFloat = 0.5
    @Published var startAnimation: CGFloat = 0
    @Published var progressDrop: CGFloat = 0.1
    @Published var name = "Bob"
    @Published var numbers = [1,2,3,4,5,6,7,8,9]
    @Published var isShowingAddDrink: Bool = false
}


struct TrackerView: View {
    @StateObject var viewModel = TrackerViewModel()
    
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
                        
                        Text("Good Morning, \(viewModel.name)")
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
                                    
                                    WaterWave(progress: viewModel.progressDrop, waveHeight: 0.05, offset: viewModel.startAnimation)
                                        .fill(Color(.blue))
                                        .modifier(MaskedImageModifier())
                                        .modifier(CircleOverlayModifier())
                                }
                                .frame(width: size.width, height: size.height, alignment: .center)
                                .onAppear {
                                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)){
                                        viewModel.startAnimation = size.width
                                    }
                                }
                                
                            }
                            .frame(height: 240)
                            
                        }
                        
                        Button {
                            viewModel.isShowingAddDrink = true
                            viewModel.progressDrop += 0.2
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
                        .padding(.top, 200)
                        .padding(.leading, 150)
                        .sheet(isPresented: $viewModel.isShowingAddDrink, content: {
                            DrinkAddView(isShowingDetail: $viewModel.isShowingAddDrink)
                        })
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
                            ForEach(self.viewModel.numbers, id: \.self) {
                                Text("\($0)")
                            }
                            .onDelete { index in
                            }
                        }.frame(width: 350, height: 150, alignment: .center)
                            .listStyle(.plain)
                            .cornerRadius(30, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }
    }
    
}
#Preview {
    TrackerView()
}


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


struct WaterProgressView: View {
    @ObservedObject var viewModel: TrackerViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(height: 288)
                .foregroundColor(.white)
                .shadow(color: Color(.black).opacity(0.25), radius: 2, x: 0, y: 4)
            
            VStack {
                Text("1500/3000 ml")
                    .foregroundColor(.black)
                
                GeometryReader { proxy in
                    let size = proxy.size
                    WaterWave(progress: viewModel.progressDrop, waveHeight: 0.05, offset: viewModel.startAnimation)
                        .fill(Color.blue)
                        .modifier(MaskedImageModifier())
                        .modifier(CircleOverlayModifier())
                        .frame(width: size.width, height: size.height, alignment: .center)
                        .onAppear {
                            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                                viewModel.startAnimation = size.width
                            }
                        }
                }
                .frame(height: 240)
            }
            
            Button {
                viewModel.isShowingAddDrink = true
            } label: {
                Image(systemName: "plus")
                    .modifier(AddDrinkButton())
            }
            .padding(.top, 200)
            .padding(.leading, 150)
            .sheet(isPresented: $viewModel.isShowingAddDrink) {
                DrinkAddView(isShowingDetail: $viewModel.isShowingAddDrink)
            }
        }
    }
}
