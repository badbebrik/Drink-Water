//
//  OnboardingView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 12.03.2024.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: Int = 0
    @Published var onboardingFinished = false
    
    let onboardingSteps: [OnboardingStep]
    
    init() {
        self.onboardingSteps = [
            OnboardingStep(imageBackground: "Vector", imageForeground: "drinkingHuman", title: "Track your daily water intake with Us.", description: "Achieve your hydration goals \nwith a simple tap!", backgroundImageHeight: 300, backgroundImageWidth: 265, foregroundImageHeight: 300, foregroundImageWidth: 310),
            OnboardingStep(imageBackground: "curveForm", imageForeground: "plants", title: "Keep motivation with \nplants growing gamification ", description: "Drink water and water the plants!\nHow many plants can you grow?", backgroundImageHeight: 310, backgroundImageWidth: 280, foregroundImageHeight: 200, foregroundImageWidth: 200),
            OnboardingStep(imageBackground: "curveForm", imageForeground: "bell", title: "Custom remainders", description: "Quick and easy to set your hydration goal \nand then track your daily \nwater intake progress.", backgroundImageHeight: 300, backgroundImageWidth: 265, foregroundImageHeight: 200, foregroundImageWidth: 200)
        ]
    }
    
    func nextStep() {
        currentStep += 1
        if currentStep >= onboardingSteps.count {
            onboardingFinished = true
        }
    }
}

struct OnboardingView: View {
    
    @StateObject var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Color(.brandBlue)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        self.viewModel.currentStep -= 1
                    } label: {
                        if self.viewModel.currentStep != 0 {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(.blue)
                                .padding()
                        } else {
                            EmptyView()
                        }
                    }
                    
                    Spacer()
                }
                
                TabView(selection: $viewModel.currentStep) {
                    ForEach(0..<viewModel.onboardingSteps.count, id: \.self) { step in
                        
                        VStack {
                            ZStack {
                                Image(viewModel.onboardingSteps[step].imageBackground)
                                    .resizable()
                                    .frame(width: viewModel.onboardingSteps[step].backgroundImageWidth, height: viewModel.onboardingSteps[step].backgroundImageHeight)
                                
                                Image(viewModel.onboardingSteps[step].imageForeground)
                                    .resizable()
                                    .frame(width: viewModel.onboardingSteps[step].foregroundImageWidth, height: viewModel.onboardingSteps[step].foregroundImageHeight)
                            }
                            
                            Text(viewModel.onboardingSteps[step].title)
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            
                            Text(viewModel.onboardingSteps[step].description)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.38, green: 0.36, blue: 0.36))
                            
                            Button {
                                viewModel.nextStep()
                            } label: {
                                Text(viewModel.currentStep == viewModel.onboardingSteps.count - 1 ? "Register" : "Next")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .frame(width: 300, height: 50)
                                
                            }
                            
                        }
                        
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }
            
        }
        .fullScreenCover(isPresented: $viewModel.onboardingFinished) {
            RegistrationFirstStepView()
        }
    }
}

#Preview {
    OnboardingView()
}
