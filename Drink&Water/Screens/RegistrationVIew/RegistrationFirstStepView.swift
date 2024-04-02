//
//  RegistrationFirstStepView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 03.03.2024.
//

import SwiftUI


class RegistrationFirstStepViewModel: ObservableObject {
    
    var name: String = ""
    var lastName: String = ""
    @Published var genderIndex = 0
    
    func validateFields() -> Bool {
        if name.isEmpty || lastName.isEmpty {
            return false
        }
        return true
    }
}


struct RegistrationFirstStepView: View {
    let genders = ["Male", "Female"]
    @StateObject private var viewModel = RegistrationFirstStepViewModel()
    @State var isShowingNextStep = false
    @State private var showAlert = false
    
    func localizedString(forKey key: String, value: String? = nil, language: String) -> String {
        let bundle = Bundle.forLanguage(language) ?? Bundle.main
        return NSLocalizedString(key, bundle: bundle, value: value ?? "", comment: "")
    }
    
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
                            ForEach(0..<genders.count) { index in
                                Text(localizedString(forKey: genders[index], language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"))
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.leading)
                        .padding(.trailing)
                    }
                }
                
                Button {
                    if viewModel.validateFields() {
                        isShowingNextStep = true
                    } else {
                        showAlert = true
                    }
                } label: {
                    Text("Next")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
                .fullScreenCover(isPresented: $isShowingNextStep, content: {
                    RegistrationSecondStepView(name: $viewModel.name, lastName: $viewModel.lastName, genderIndex: $viewModel.genderIndex)
                })
                
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Empty Fields"), message: Text("Please fill in both first name and last name."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    RegistrationFirstStepView()
}
