//
//  AboutView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 12.03.2024.
//

import SwiftUI
import MapKit

struct AboutView: View {
    let developerName = "Viktoria Serikova"
    let contactNumber = "+1234567890"
    let office = "HSE University"
    let email = "vika.serikova@icloud.com"
    let officeLocation = CLLocationCoordinate2D(latitude: 55.7535828736976, longitude: 37.64822830422969)
    
    var body: some View {
        VStack {
            Image("dev")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding(.top, 40)
            
            Text("Dev: \(developerName)")
                .font(.title)
                .foregroundColor(.blue)
                .padding()
            
            Text("Phone number: \(contactNumber)")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
            
            Text("Email: \(email)")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
            
            Text("Office: \(office)")
            
            MapView(location: officeLocation)
                .frame(height: 300)
                .cornerRadius(10)
                .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
}


struct MapView: UIViewRepresentable {
    let location: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(region, animated: true)
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

#Preview {
    AboutView()
}
