//
//  ContentView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 19.02.2024.
//

import SwiftUI
import UIKit



struct OnboardingStep {
    let imageBackground: String
    let imageForeground: String
    let title: String
    let description: String
    let backgroundImageHeight: CGFloat
    let backgroundImageWidth: CGFloat
    let foregroundImageHeight: CGFloat
    let foregroundImageWidth: CGFloat
}

private let onboardingSteps = [
    OnboardingStep(imageBackground: "Vector", imageForeground: "drinkingHuman", title: "Track your daily water intake with Us.", description: "Achieve your hydration goals \nwith a simple tap!", backgroundImageHeight: 300, backgroundImageWidth: 265, foregroundImageHeight: 300, foregroundImageWidth: 310),
    OnboardingStep(imageBackground: "curveForm", imageForeground: "plants", title: "Keep motivation with \nplants growing gamification ", description: "Drink water and water the plants!\nHow many plants can you grow?", backgroundImageHeight: 310, backgroundImageWidth: 280, foregroundImageHeight: 200, foregroundImageWidth: 200),
    OnboardingStep(imageBackground: "curveForm", imageForeground: "bell", title: "Custom remainders", description: "Quick and easy to set your hydration goal \nand then track your daily \nwater intake progress.", backgroundImageHeight: 300, backgroundImageWidth: 265, foregroundImageHeight: 200, foregroundImageWidth: 200)
]

struct ContentView: View {
    
    @State var currentStep: Int = 0
    @State var onboardingFinished = false
    
    
    var body: some View {
        ZStack {
            Color(.brandBlue)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        self.currentStep -= 1
                    } label: {
                        if self.currentStep != 0 {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(.blue)
                        } else {
                            EmptyView()
                        }
                    }
                    
                    Spacer()
                }
                
                TabView(selection: $currentStep) {
                    ForEach(0..<onboardingSteps.count, id: \.self) { step in
                        
                        VStack {
                            ZStack {
                                Image(onboardingSteps[step].imageBackground)
                                    .resizable()
                                    .frame(width: onboardingSteps[step].backgroundImageWidth, height: onboardingSteps[step].backgroundImageHeight)
                                
                                Image(onboardingSteps[step].imageForeground)
                                    .resizable()
                                    .frame(width: onboardingSteps[step].foregroundImageWidth, height: onboardingSteps[step].foregroundImageHeight)
                            }
                            
                            Text(onboardingSteps[step].title)
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            
                            Text(onboardingSteps[step].description)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.38, green: 0.36, blue: 0.36))
                            
                            Button {
                                if (currentStep == onboardingSteps.count - 1) {
                                    onboardingFinished = true
                                }
                                currentStep = (currentStep + 1) % onboardingSteps.count
                            } label: {
                                Text("Next")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .frame(width: 300, height: 50)
                                
                            }
                            
                            .fullScreenCover(isPresented: $onboardingFinished, content: {
                                DrinkWaterTabView()
                            })
                            
                        }
                        
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }
            
        }
    }
}

#Preview {
    ContentView()
}



