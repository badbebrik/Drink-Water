import SwiftUI

struct AccountView: View {
    @State private var isShowingImagePicker = false
    
    @StateObject var viewModel: AccountViewModel = AccountViewModel()
    
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
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    
                    Form {
                        Section(header: Text("Profile photo")) {
                            if let image = viewModel.image {
                                HStack {
                                    Spacer()
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 200, height: 200)
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .padding()
                                    Spacer()
                                }
                                Button("Change Image") {
                                    isShowingImagePicker = true
                                }
                                .padding()
                                .sheet(isPresented: $isShowingImagePicker) {
                                    ImagePicker(image: Binding<UIImage?>(get: {
                                        self.viewModel.image
                                    }, set: { newImage in
                                        self.viewModel.image = newImage
                                        if let newImage = newImage {
                                            self.viewModel.saveProfileImage(newImage)
                                        }
                                    }))
                                }
                            } else {
                                Button("Select Image") {
                                    isShowingImagePicker = true
                                }
                                .padding()
                                .sheet(isPresented: $isShowingImagePicker) {
                                    ImagePicker(image: Binding<UIImage?>(get: {
                                        self.viewModel.image
                                    }, set: { newImage in
                                        self.viewModel.image = newImage
                                        if let newImage = newImage {
                                            self.viewModel.saveProfileImage(newImage)
                                        }
                                    }))
                                }
                            }
                        }
                        
                        Section(header: Text("Personal Information")) {
                            TextField("First Name", text: $viewModel.firstName)
                            TextField("Last Name", text: $viewModel.lastName)
                            Picker("Gender", selection: $viewModel.genderIndex) {
                                ForEach(0..<genders.count) { index in
                                    Text(LocalizedStringKey(genders[index]))
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
                            Picker("Activity", selection: $viewModel.activity) {
                                ForEach(activityModes, id: \.self) { mode in
                                    Text(LocalizedStringKey(mode))
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section(header: Text("Save Changes")) {
                            Button() {
                                viewModel.updateUser()
                            } label: {
                                Text("Save")
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
}



struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
