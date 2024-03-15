import SwiftUI


class AccountViewModel: ObservableObject {
    var height: Double = 0
    var weight: Double = 0
    var birthday: Date = Date.now
}


struct AccountView: View {
    
    @StateObject var viewModel: AccountViewModel = AccountViewModel()
    
    @State private var image: UIImage? = nil
    @State private var isShowingImagePicker = false
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var genderIndex = 0
    @State private var activity: String = ""
    @State private var isRefreshing = false

    
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
                            Picker("Gender", selection: $genderIndex) {
                                ForEach(0..<genders.count) { index in
                                    Text(genders[index])
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section(header: Text("Birthday")) {
                            DatePicker("Select a date", selection: $viewModel.birthday, in: Date(timeIntervalSince1970: 0)...Date(), displayedComponents: .date)
                                .datePickerStyle(.automatic)
                                .labelsHidden()
                                .padding()
                                .onChange(of: viewModel.birthday) { newValue in
                                    let calendar = Calendar.current
                                }
                        }
                        
                        Section(header: Text("Physical Information")) {
                            HStack {
                                Text("Height:")
                                    .foregroundColor(.secondary)
                                TextField("Enter height (cm)", value: $viewModel.height, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                            }
                            .padding(.horizontal)

                            HStack {
                                Text("Weight:")
                                    .foregroundColor(.secondary)
                                TextField("Enter weight (kg)", value: $viewModel.weight, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                            }
                            .padding(.horizontal)
                        }
                        
                        Section(header: Text("Activity Mode")) {
                            Picker("Activity", selection: $activity) {
                                ForEach(activityModes, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section(header: Text("Save Changes")) {
                            Button() {
                                coreDataManager.updateUser(name: firstName, lastName: lastName, gender: genderIndex, weight: viewModel.weight, height: viewModel.height, birthday: viewModel.birthday, activity: activity, todayWaterIntake: 0)
                            } label: {
                                Text("Save")
                            }
                        }
                    }
                }
            }
            .onAppear {
                if let userData = coreDataManager.getUserData() {
                    firstName = userData.name ?? ""
                    lastName = userData.lastName ?? ""
                    viewModel.height = userData.height
                    viewModel.weight = userData.weight
                    genderIndex = Int(userData.gender)
                    activity = userData.activity ?? "Low"
                    viewModel.birthday = userData.birthday!
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
