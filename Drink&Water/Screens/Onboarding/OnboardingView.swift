//
//  OnboardingView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 12.03.2024.
//

import SwiftUI

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
                            
                            VStack(spacing: 20) {
                                Text(LocalizationManager.shared.localizeString(forKey: viewModel.onboardingSteps[step].title, language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"))
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                                
                                Text(LocalizationManager.shared.localizeString(forKey: viewModel.onboardingSteps[step].description, language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"))
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 0.38, green: 0.36, blue: 0.36))
                            }
                            .padding()
                            
                            
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
