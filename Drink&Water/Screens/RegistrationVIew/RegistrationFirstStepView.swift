//
//  RegistrationFirstStepView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 03.03.2024.
//

import SwiftUI

struct RegistrationFirstStepView: View {
    
    @State var name: String = ""
    @State var lastName: String = ""
    let genders = ["Male", "Female"]
    @State private var gender: Bool = false
    @State private var isShowingNextStep = false

    
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
                        Text("First Name")
                            .frame(width: 353, alignment: .leading)
                        TextField("", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .padding(.leading)
                            .padding(.trailing)
                    }
                    
                    VStack(spacing: 10) {
                        Text("Last Name")
                            .frame(width: 353, alignment: .leading)
                        
                        TextField("", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.leading)
                            .padding(.trailing)
                    }
                    
                }
                
                VStack {
                    
                    Text("Gender")
                        .frame(width: 353, alignment: .leading)
                    HStack {
                        Picker("Gender", selection: $gender) {
                            ForEach(genders, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.leading)
                        .padding(.trailing)
                    }
                }
                
                Button {
                    isShowingNextStep = true
                } label: {
                    Text("Next")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
                .fullScreenCover(isPresented: $isShowingNextStep, content: {
                    RegistrationSecondStepView(name: $name, lastName: $lastName, gender: $gender)
                })

            }
        }
    }
}

#Preview {
    RegistrationFirstStepView()
}
