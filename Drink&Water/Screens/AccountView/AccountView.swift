//
//  AccountView.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 21.02.2024.
//

import SwiftUI

struct AccountView: View {
    
    @State private var image: UIImage? = nil
    @State private var isShowingImagePicker = false
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var height = ""
    @State private var weight = ""
    @State private var gender = "Male"
    @State private var activity = ""
    
    let genders = ["Male", "Female"]
    let activityMode = ["Low", "Medium", "High"]
    
    var body: some View {
        ZStack {
            Color(.brandBlue)
                .ignoresSafeArea()
            
            
            VStack {
                Text("Account")
                    .font(.system(size: 32, weight: .black))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .frame(width: 353, height: 26, alignment: .leading)
                
                Form {
                    Section(header: Text("Profile photo")) {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .cornerRadius(10)
                                .padding()
                            Button("Change Image") {
                                isShowingImagePicker = true
                            }
                            .padding()
                            .sheet(isPresented: $isShowingImagePicker) {
                                ImagePicker(image: $image)
                            }
                        } else {
                            Button("Select Image") {
                                isShowingImagePicker = true
                            }
                            .padding()
                            .sheet(isPresented: $isShowingImagePicker) {
                                ImagePicker(image: $image)
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Personal Information")) {
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastName)
                        TextField("Email", text: $email)
                    }
                    
                    Section(header: Text("Physical Information")) {
                        TextField("Height (cm)", text: $height)
                            .keyboardType(.numberPad)
                        TextField("Weight (kg)", text: $weight)
                            .keyboardType(.numberPad)
                        HStack(spacing: 40) {
                            Text("Activity")
                            Picker("Gender", selection: $activity) {
                                ForEach(activityMode, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    
                    Section(header: Text("Gender")) {
                        Picker("Gender", selection: $gender) {
                            ForEach(genders, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    
                    Section {
                        Button("Submit") {
                            // Здесь можно выполнить действие по отправке данных
                            // Например, вы можете отправить данные на сервер или сохранить их локально
                            // В этом примере просто выводим данные в консоль
                            print("First Name: \(firstName)")
                            print("Last Name: \(lastName)")
                            print("Email: \(email)")
                            print("Height: \(height)")
                            print("Weight: \(weight)")
                            print("Gender: \(gender)")
                        }
                    }
                    
                    
                }
                
            }
        }
    }
    
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var image: UIImage?
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            let parent: ImagePicker
            
            init(parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let uiImage = info[.originalImage] as? UIImage {
                    parent.image = uiImage
                }
                
                picker.dismiss(animated: true)
            }
        }
        
        func makeCoordinator() -> Coordinator {
            return Coordinator(parent: self)
        }
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = .photoLibrary
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    }
}


#Preview {
    AccountView()
}
