//
//  RegistrationSecondStepView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 03.03.2024.
//

import SwiftUI

class RegistrationSecondStepViewModel: ObservableObject {
    private var registrationFirstStepViewModel = RegistrationFirstStepViewModel()
    @Published var activity: String = "Low"
    @Published var selectedDate: Date = Date()
    @Published var height: Double = 100
    @Published var weight: Double = 20
    @Published  var isRegistrationFinished = false
    let activityMode = ["Low", "Medium", "High"]
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    init(_ registrationFirstStepViewModel: RegistrationFirstStepViewModel) {
        self.registrationFirstStepViewModel = registrationFirstStepViewModel
    }
    
    func registerButtonPressed() {
        let coreDataManager = CoreDataManager()
        coreDataManager.saveUser(name: registrationFirstStepViewModel.name, lastName: registrationFirstStepViewModel.lastName, gender: registrationFirstStepViewModel.genderIndex, weight: weight, height: height, birthday: selectedDate, activity: activity, balance: 100)
        UserDefaults.standard.set(true, forKey: "isUserRegistered")
        
        isRegistrationFinished = true
    }
    
    
}

struct RegistrationSecondStepView: View {
    @StateObject var viewModel = RegistrationSecondStepViewModel(RegistrationFirstStepViewModel())
    

    var body: some View {
        ZStack {
            Color(.brandBlue)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                Text("Registration")
                    .font(.system(size: 32, weight: .black))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .frame(width: 353, height: 26, alignment: .center)
                
                
                VStack(spacing: 20) {
                    
                    VStack(spacing: 10) {
                        Text("Height (cm)")
                            .frame(width: 353, alignment: .leading)
                        Slider(value: $viewModel.height, in: 100...240) {}
                    minimumValueLabel: {
                        Text("100").font(.title2).fontWeight(.thin)
                    } maximumValueLabel: {
                        Text("240").font(.title2).fontWeight(.thin)
                    }
                        
                    .padding()
                        Text("\(viewModel.numberFormatter.string(for: viewModel.height) ?? "")")
                    }
                    
                    VStack(spacing: 10) {
                        Text("Weight (kg)")
                            .frame(width: 353, alignment: .leading)
                        Slider(value: $viewModel.weight, in: 20...300) {}
                    minimumValueLabel: {
                        Text("20").font(.title2).fontWeight(.thin)
                    } maximumValueLabel: {
                        Text("300").font(.title2).fontWeight(.thin)
                    }
                    .padding()
                        Text("\(viewModel.numberFormatter.string(for: viewModel.weight) ?? "")")
                        
                    }
                    
                    Text("Birthday")
                        .frame(width: 353, alignment: .leading)
                    
                    DatePicker("Select a date", selection: $viewModel.selectedDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.automatic)
                        .labelsHidden()
                        .padding()
                        .onChange(of: viewModel.selectedDate) { newValue in
                            let calendar = Calendar.current
                            let selectedYear = calendar.component(.year, from: newValue)
                            if selectedYear > 2018 {
                                viewModel.selectedDate = calendar.date(from: DateComponents(year: 2018)) ?? Date()
                            }
                        }
                        .onAppear {
                            viewModel.selectedDate = Date()
                        }
                    
                    Text("Activity")
                        .frame(width: 353, alignment: .leading)
                    Picker("Activity", selection: $viewModel.activity) {
                        ForEach(viewModel.activityMode, id: \.self) {
                            Text(LocalizationManager.shared.localizeString(forKey:$0, language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Button {
                        viewModel.registerButtonPressed()
                    } label: {
                        Text("Register")
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .fullScreenCover(isPresented: $viewModel.isRegistrationFinished, content: {
                        DrinkWaterTabView()
                    })
                    
                }
            }
        }
    }
    
    
}

#Preview {
    RegistrationSecondStepView(viewModel: RegistrationSecondStepViewModel(RegistrationFirstStepViewModel()))
}




