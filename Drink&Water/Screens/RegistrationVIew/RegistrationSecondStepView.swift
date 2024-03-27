//
//  RegistrationSecondStepView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 03.03.2024.
//

import SwiftUI

class RegistrationSecondStepViewModel: ObservableObject {
    var activity: String = "Low"
    var selectedDate: Date = Date()
    @Published var height: Double = 100
    @Published var weight: Double = 20
}

struct RegistrationSecondStepView: View {
    @StateObject var viewModel = RegistrationSecondStepViewModel()
    let coreDataManager = CoreDataManager()
    @Binding var name: String
    @Binding var lastName: String
    @Binding var genderIndex: Int
    
    @State private var isRegistrationFinished = false
    let activityMode = ["Low", "Medium", "High"]
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
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
                        Text("Height (m)")
                            .frame(width: 353, alignment: .leading)
                        Slider(value: $viewModel.height, in: 100...240) {}
                    minimumValueLabel: {
                        Text("100").font(.title2).fontWeight(.thin)
                    } maximumValueLabel: {
                        Text("240").font(.title2).fontWeight(.thin)
                    }
                        
                    .padding()
                        Text("\(numberFormatter.string(for: viewModel.height) ?? "")")
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
                        Text("\(numberFormatter.string(for: viewModel.weight) ?? "")")
                        
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
                        ForEach(activityMode, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Button {
                        coreDataManager.saveUser(name: name, lastName: lastName, gender: genderIndex, weight: viewModel.weight, height: viewModel.height, birthday: viewModel.selectedDate, activity: viewModel.activity, balance: 100)
                        UserDefaults.standard.set(true, forKey: "isUserRegistered")
                        
                        isRegistrationFinished = true
                    } label: {
                        Text("Register")
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .fullScreenCover(isPresented: $isRegistrationFinished, content: {
                        DrinkWaterTabView()
                    })
                    
                }
            }
        }
    }
    
    
}

#Preview {
    RegistrationSecondStepView(name: .constant("Bob"), lastName: .constant("Poopkins"), genderIndex: .constant(0))
}




