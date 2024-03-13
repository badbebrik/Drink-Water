import SwiftUI

struct AccountView: View {
    
    @State private var image: UIImage? = nil
    @State private var isShowingImagePicker = false
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var height: String = "0"
    @State private var weight: String = "0"
    @State private var genderIndex = 0
    @State private var activityIndex = 0
    
    let genders = ["Male", "Female"]
    let activityModes = ["Low", "Medium", "High"]
    let coreDataManager = CoreDataManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.brandBlue)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Account")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.white)
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
                        }
                        
                        Section(header: Text("Physical Information")) {
                            TextField("Height (cm)", text: $height)
                                .keyboardType(.numberPad)
                            TextField("Weight (kg)", text: $weight)
                                .keyboardType(.numberPad)
                        }
                        
                        Section(header: Text("Gender")) {
                            Picker("Gender", selection: $genderIndex) {
                                ForEach(0..<genders.count) { index in
                                    Text(genders[index])
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section(header: Text("Activity Mode")) {
                            Picker("Activity Mode", selection: $activityIndex) {
                                ForEach(0..<activityModes.count) { index in
                                    Text(activityModes[index])
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section {
//                            Button("Submit") {
//                                coreDataManager.updateUser(name: firstName, lastName: lastName, gender: genderIndex, weight: weight, height: height, birthday: Date.now)
//                            }
                        }
                        
                    }
                }
            }
            .onAppear {
                if let userData = coreDataManager.getUserData() {
                    firstName = userData.name ?? ""
                    lastName = userData.lastName ?? ""
                    height = "\(userData.height)"
                    weight = "\(userData.weight)"
                    genderIndex = userData.gender ? 0 : 1
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

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
