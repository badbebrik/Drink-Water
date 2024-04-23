//
//  PlantView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI


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
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                Spacer()
                if (!viewModel.plants.isEmpty) {
    
                    List {
                        
                        ForEach(viewModel.plants, id: \.id) { plant in
                            HStack(spacing: 50) {
                                 
                                HStack(spacing: 20) {
                                        Image(plant.name + " adult")
                                            .resizable()
                                            .frame(width: 70, height: 100)
                                        Text(plant.name.capitalized)
                                    }
                                    .onTapGesture {
                                        self.viewModel.selectedPlantForDetail = plant
                                    }
                                
                                
                                Spacer()
                                
                                Button(action: {
                                    self.viewModel.selectedPlantForDeletion = plant
                                    self.viewModel.showingDeleteAlert = true
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                            }
                        }
                        .alert(isPresented: $viewModel.showingDeleteAlert) {
                            Alert(
                                title: Text("Delete Plant"),
                                message: Text("Are you sure you want to delete this plant? This action cannot be undone."),
                                primaryButton: .destructive(Text("Delete")) {
                                    viewModel.deletePlant()

                                },
                                secondaryButton: .cancel()
                            )
                        }
                        
                    }
                }
                else {
                    Text("You have no grown plants yet.")
                    Spacer()
                }
                
                
            }
            .onAppear {
                viewModel.fetchPlants()
            }
            
            if let plant = viewModel.selectedPlantForDetail {
                PlantDetailOverlayView(plant: plant) {
                    self.viewModel.selectedPlantForDetail = nil // Закрыть оверлей
                }
                .transition(.opacity)
            }
        }
    }
}


struct PlantDetailOverlayView: View {
    let plant: Plant
    let onClose: () -> Void
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 15) {
            Image("\(plant.name) adult")
                .resizable()
                .frame(width: 150, height: 180)
            
            VStack {
                Text(plant.name.capitalized)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                HStack(alignment: .center) {
                    Text("Have drunk to grow: \(plant.totalToGrow) ml")
                    Image("drop")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                HStack(alignment: .center) {
                    Text("Got the reward: \(Int(Double(plant.price) * 1.5))")
                    Image("coin")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                Text("Start: \(plant.startGrowDate, formatter: dateFormatter)")
                Text("Finish: \(plant.finishGrowDate, formatter: dateFormatter)")

            }
            
    
        }
        
        .frame(width: 300, height: 500)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .overlay(
            Button(action: {
                onClose()
            }) {
                Image(systemName: "xmark")
                    .padding()
            },
            alignment: .topTrailing
        )
    }
}


#Preview {
    PlantsView()
}

