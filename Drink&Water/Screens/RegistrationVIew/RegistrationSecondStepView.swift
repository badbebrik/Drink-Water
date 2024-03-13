//
//  RegistrationSecondStepView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 03.03.2024.
//

import SwiftUI



struct RegistrationSecondStepView: View {
    
    let coreDataManager = CoreDataManager()
    @Binding var name: String
    @Binding var lastName: String
    @Binding var gender: Bool
    @State var height: Double = 0
    @State var weight: Double = 0
    @State private var activity = ""
    @State private var selectedDate = Date()
    @State private var isRegistrationFinished = false
    let activityMode = ["Low", "Medium", "High"]
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
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
                        Text("Height")
                            .frame(width: 353, alignment: .leading)
                        Slider(value: $height, in: 0...240) {}
                    minimumValueLabel: {
                        Text("0").font(.title2).fontWeight(.thin)
                    } maximumValueLabel: {
                        Text("240").font(.title2).fontWeight(.thin)
                    }
                        
                    .padding()
                        Text("\(numberFormatter.string(for: height) ?? "")")
                    }
                    
                    VStack(spacing: 10) {
                        Text("Weight")
                            .frame(width: 353, alignment: .leading)
                        Slider(value: $weight, in: 0...300) {}
                    minimumValueLabel: {
                        Text("0").font(.title2).fontWeight(.thin)
                    } maximumValueLabel: {
                        Text("300").font(.title2).fontWeight(.thin)
                    }
                    .padding()
                        Text("\(numberFormatter.string(for: weight) ?? "")")
                        
                    }
                    
                    Text("Birthday")
                        .frame(width: 353, alignment: .leading)
                    
                    DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.automatic)
                        .labelsHidden()
                        .padding()
                    
                    Text("Activity")
                        .frame(width: 353, alignment: .leading)
                    Picker("Gender", selection: $activity) {
                        ForEach(activityMode, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Button {
                        coreDataManager.saveUser(name: name, lastName: lastName, gender: gender, weight: weight, height: height, birthday: Date.now)
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
    RegistrationSecondStepView(name: .constant("Bob"), lastName: .constant("Poopkins"), gender: .constant(false))
}




