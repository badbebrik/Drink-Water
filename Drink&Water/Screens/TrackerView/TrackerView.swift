//
//  TrackerView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI


struct TrackerView: View {
    
    @ObservedObject var viewModel = TrackerViewModel()
    @State private var showingDeleteAlert = false
    @State var isShowingAddDrink: Bool = false
    
    
    var body: some View {
        ZStack {
            Color("BrandBlue")
                .opacity(0.7)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack(spacing: 20) {
                        Text("Tracker")
                            .font(.system(size: 32, weight: .black))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .frame(width: 353, height: 26, alignment: .leading)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                        
                        Text(viewModel.greetingBasedOnTime())
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
                            Text("\(Int(viewModel.todayWaterIntake))/\(Int(viewModel.dailyWaterIntakeGoal)) ml")
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
                                    
                                    GeometryReader { proxy in
                                        let size = proxy.size
                                        
                                        ZStack {
                                            
                                            if viewModel.isAnimating {
                                                
                                                WaterWave(progress: viewModel.progressDrop, waveHeight: 0.05, offset: viewModel.startAnimation)
                                                    .fill(Color.blue)
                                                    .modifier(MaskedImageModifier())
                                                    .modifier(CircleOverlayModifier())
                                                
                                            } else {
                                                
                                                WaterWave(progress: viewModel.progressDrop, waveHeight: 0.05, offset: viewModel.startAnimation)
                                                    .fill(Color.blue)
                                                    .modifier(MaskedImageModifier())
                                                    .modifier(CircleOverlayModifier())
                                                
                                            }
                                        }
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                        .onAppear {
                                            viewModel.isAnimating = true
                                        }
                                        .onDisappear {
                                            viewModel.isAnimating = false
                                        }
                                    }
                                    
                                }
                                .frame(width: size.width, height: size.height, alignment: .center)
                                .onAppear {
                                    viewModel.isAnimating = true
                                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                                        viewModel.startAnimation += 360
                                    }
                                }
                                .onDisappear {
                                    viewModel.isAnimating = false
                                }
                                
                            }
                            .frame(height: 240)
                            
                        }
                        
                        Button {
                            isShowingAddDrink = true
                            viewModel.progressDrop = viewModel.todayWaterIntake / viewModel.dailyWaterIntakeGoal
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
                        
                    }
                    
                    Text("Your Plant:")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                        .frame(width: 353, height: 26, alignment: .leading)
                    
                    if let currentPlant = viewModel.currentGrowingPlant {
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
                                        PlantView(plant: currentPlant , plantImageName: currentPlant.name  + " " + viewModel.checkStage(plant: currentPlant))
                                    )
                                
                                CircularProgressView(progress: Double(currentPlant.currentFillness) / Double( currentPlant.totalToGrow))
                                    .frame(width: 100)
                            }
                        }
                    } else {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 352, height: 167)
                                .background(.white)
                                .cornerRadius(30)
                            Text("No plant currently growing.\nBuy a plant in the shop!")
                                .font(.system(size: 16))
                                .foregroundStyle(.black)
                        }
                    }
                    
                    Text("Today's records:")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                        .frame(width: 353, height: 26, alignment: .leading)
                    
                    VStack {
                        
                        ForEach(viewModel.todayDrinks, id: \.id) { drink in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(radius: 5)
                                    .frame(width: 353)
                                
                                HStack {
                                    Image(drink.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                    
                                    VStack(alignment: .leading) {
                                        Text(viewModel.localizedString(forKey: drink.name, language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"))
                                            .font(.headline)
                                        
                                        Text("\(drink.volume) ml")
                                            .font(.subheadline)
                                    }
                                    .padding(.leading)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        self.viewModel.drinkToDelete = drink
                                        self.showingDeleteAlert = true
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding()
                            }
                            .frame(width: 353, height: 80)
                            .padding(.horizontal)
                        }
                        .alert(isPresented: $showingDeleteAlert) {
                            Alert(
                                title: Text("Delete Drink"),
                                message: Text("Are you sure you want to delete this drink?"),
                                primaryButton: .destructive(Text("Delete")) {
                                    viewModel.deleteDrink()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                        
                    }
                }
            }
            
        }
        .disabled(isShowingAddDrink)
        .blur(radius: isShowingAddDrink ? 3 : 0)
        .onAppear() {
            viewModel.fetchData()
        }
        .overlay(
            isShowingAddDrink ? DrinkAddView(isShowingDetail: $isShowingAddDrink, trackerViewModel: viewModel)
                .transition(.opacity): nil
            
                )
        .animation(.easeInOut, value: isShowingAddDrink)
    }
    
}

extension Bundle {
    static func forLanguage(_ lang: String) -> Bundle? {
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
              let bundle = Bundle(path: path) else { return nil }
        return bundle
    }
}

#Preview {
    TrackerView(isShowingAddDrink: false)
}
