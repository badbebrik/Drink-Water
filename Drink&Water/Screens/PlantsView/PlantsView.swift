//
//  PlantView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI


struct PlantsView: View {
    @StateObject var viewModel = PlantsViewModel()
    
    func localizedString(forKey key: String, value: String? = nil, language: String) -> String {
        let bundle = Bundle.forLanguage(language) ?? Bundle.main
        return NSLocalizedString(key, bundle: bundle, value: value ?? "", comment: "")
    }
    
    
    var body: some View {
        ZStack {
            Color(.brandBlue)
                .ignoresSafeArea()
            VStack {
                Text("Your Gallery")
                    .font(.system(size: 32, weight: .black))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .frame(width: 353, height: 26, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                Spacer()
                if (!viewModel.plants.isEmpty) {
                    List {
                        ForEach(viewModel.plants, id: \.id) { plant in
                            HStack(spacing: 20) {
                                Image(plant.name + " adult")
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                Text(localizedString(forKey: plant.name, language: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en"))
                            }
                        }
                    }
                } else {
                    Text("You have no grown plants yet.")
                    Spacer()
                }
            }
            .onAppear {
                viewModel.fetchPlants()
            }
        }
    }
}

#Preview {
    PlantsView()
}

