//
//  RegistrationFirstStepView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 03.03.2024.
//

import SwiftUI


class RegistrationFirstStepViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var lastName: String = ""
    @Published var genderIndex = 0
    @Published var isShowingNextStep = false
    @Published var showAlert = false
    let genders = ["Male", "Female"]
    
    func validateFields() -> Bool {
        if name.isEmpty || lastName.isEmpty {
            return false
        }
        return true
    }
    
    func nextButtonPressed() {
        if validateFields() {
            isShowingNextStep = true
        } else {
            showAlert = true
        }
    }
}


struct RegistrationFirstStepView: View {
    @StateObject private var viewModel = RegistrationFirstStepViewModel()

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
                        TextField("", text: $viewModel.name)
                            .autocorrectionDisabled()
                            .autocapitalization(.sentences)
                            .textFieldStyle(.roundedBorder)
                            .padding(.leading)
                            .padding(.trailing)
                    }
                    
                    VStack(spacing: 10) {
                        Text("Last Name")
                            .frame(width: 353, alignment: .leading)
                        
                        TextField("", text: $viewModel.lastName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.leading)
                            .padding(.trailing)
                            .autocorrectionDisabled()
                            .autocapitalization(.sentences)
                    }
                    
                }
                
                VStack {
                    Text("Gender")
                        .frame(width: 353, alignment: .leading)
                    HStack {
                        Picker("Gender", selection: $viewModel.genderIndex) {
                            ForEach(0..<viewModel.genders.count) { index in
                                Text(LocalizationManager.shared.localizeString(forKey: viewModel.genders[index], language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"))
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.leading)
                        .padding(.trailing)
                    }
                }
                
                Button {
                    viewModel.nextButtonPressed()
                } label: {
                    Text("Next")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
                .fullScreenCover(isPresented: $viewModel.isShowingNextStep, content: {
                    RegistrationSecondStepView(viewModel: RegistrationSecondStepViewModel(viewModel))
                })
                
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Empty Fields"), message: Text("Please fill in both first name and last name."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    RegistrationFirstStepView()
}
