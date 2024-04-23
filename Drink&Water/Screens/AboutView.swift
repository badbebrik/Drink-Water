//
//  AboutView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 12.03.2024.
//

import SwiftUI
import MapKit


struct DeveloperModel {
    let developerName = "Viktoria Serikova"
    let contactNumber = "+1234567890"
    let office = "HSE University"
    let email = "vika.serikova@icloud.com"
    let officeLocation = CLLocationCoordinate2D(latitude: 55.7535828736976, longitude: 37.64822830422969)
}

class AboutViewModel: ObservableObject {
    let developerModel = DeveloperModel()
    
}

struct AboutView: View {
    @StateObject var viewModel = AboutViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            
            Text("Dev: \(viewModel.developerModel.developerName)")
                .font(.title)
                .foregroundColor(.blue)

            
            Text("Phone number: \(viewModel.developerModel.contactNumber)")
                .font(.headline)
                .foregroundColor(.gray)
            
            Text("Email: \(viewModel.developerModel.email)")
                .font(.headline)
                .foregroundColor(.gray)
            
            Button(action: {
                            if let url = URL(string: "https://t.me/badbebrik") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("Telegram")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .padding()
            
            Text("Office: \(viewModel.developerModel.office)")
            
            MapView(location: viewModel.developerModel.officeLocation)
                .frame(height: 300)
                .cornerRadius(10)
                .padding()
        }
        .frame(height: 600)
        .background(Color.white)
        .cornerRadius(20)
        .padding()
        .shadow(radius: 10)
        .overlay(
            Button(action: {
                settingsViewModel.isShowingAboutPage = false
            })
            {
                Image(systemName: "xmark")
                    .padding()
            }.padding(),
            alignment: .topTrailing
                
            
        )
        
    }
    
}

struct MapView: UIViewRepresentable {
    let location: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(region, animated: true)
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

#Preview {
    AboutView()
}
