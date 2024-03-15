//
//  PlantView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI


class PlantsViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    
    func fetchPlants() {
        let coreDataManager = CoreDataManager()
        if let allPlants = coreDataManager.getAllPlants() {
            plants = allPlants.filter { $0.currentFillness >= $0.totalToGrow }
        }
    }
}


struct PlantsView: View {
    @StateObject var viewModel = PlantsViewModel()
    
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
                Spacer()
                if (!viewModel.plants.isEmpty) {
                    List {
                        ForEach(viewModel.plants, id: \.id) { plant in
                            HStack(spacing: 20) {
                                Image(plant.name + " adult")
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                Text(plant.name)
                                
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

