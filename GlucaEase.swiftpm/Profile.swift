import SwiftUI

struct Profile: View {
    @Binding var isProfilePresented: Bool
    
    @State private var diabetesType: String? = nil
    @State private var height = ""
    @State private var weight = ""
    @State private var insulinType: String? = nil
    @State private var insulinDosage = ""
    @State private var insulinTimes = ""
    
    @State private var selectedHeightUnit = "cm" // Default unit for height
    @State private var selectedWeightUnit = "kg" // Default unit for weight
    
    @State private var profileImage: UIImage? = nil // Profile image
    @State private var showImagePicker = false // Show image picker
    
    let diabetesTypes = ["Type 1", "Type 2", "Gestational", "Pre-Diabetes"]
    let heightUnits = ["cm", "inches"]
    let weightUnits = ["kg", "lbs"]
    let insulinTypes = ["Basal", "Prandial"]
    
    @State private var medicationText: String = "" // Holds the text input from the user
    @State private var medications: [String] = [] // List to store added medications
    @State private var showReminderModal: Bool = false
    @EnvironmentObject var reminderManager:ReminderManager
    
    private var bmi: Double {
        guard let weightValue = Double(weight), weightValue > 0 else {
            return 0
        }
        
        guard let heightValue = Double(height), heightValue > 0 else {
            return 0
        }
        
        let weightInKg: Double
        if selectedWeightUnit == "lbs" {
            weightInKg = weightValue / 2.20462
        } else {
            weightInKg = weightValue
        }
        
        let heightInMeters: Double
        if selectedHeightUnit == "cm" {
            heightInMeters = heightValue / 100
        } else if selectedHeightUnit == "inches" {
            heightInMeters = heightValue * 0.0254
        } else {
            heightInMeters = heightValue
        }
        
        return weightInKg / (heightInMeters * heightInMeters)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Image Section
                    ProfileImageSection(profileImage: $profileImage, showImagePicker: $showImagePicker)
                    
                    // Personal Information Section
                    PersonalInformationSection(
                        diabetesType: $diabetesType,
                        height: $height,
                        weight: $weight,
                        selectedHeightUnit: $selectedHeightUnit,
                        selectedWeightUnit: $selectedWeightUnit,
                        bmi: bmi
                    )
                    
                    // Insulin Information Section
                    InsulinInformationSection(
                        insulinType: $insulinType,
                        insulinDosage: $insulinDosage,
                        insulinTimes: $insulinTimes
                    )
                    
                    OtherMedicationsSection(
                        medicationText: $medicationText,
                        medications: $medications,
                        showReminderModal: $showReminderModal,
                        reminderManager: reminderManager
                    )
                }
                .onTapGesture {
                    dismissKeyboard()
                }
                .sheet(isPresented: $showReminderModal){
                    SetReminderModalView(isPresented: $showReminderModal, reminderManager: reminderManager, title: medicationText)
                        .onDisappear {
                            // Ensure the reminders are properly updated when the modal is dismissed
                            print("Reminder Modal was dismissed. Current reminders count: \(reminderManager.reminders.count)")
                        }
                }
            }
            .navigationBarItems(trailing: Button("Save") {
                saveProfileData()
            })
            .navigationBarTitle("Profile", displayMode: .inline)
            .background(Color(hex: "#E0E3F0"))
            .onAppear {
                loadProfileData()
            }
        }
    }
    
    // MARK: - Save Profile Data
    private func saveProfileData() {
        UserDefaults.standard.set(diabetesType, forKey: "diabetesType")
        UserDefaults.standard.set(height, forKey: "height")
        UserDefaults.standard.set(weight, forKey: "weight")
        UserDefaults.standard.set(insulinType, forKey: "insulinType")
        UserDefaults.standard.set(insulinDosage, forKey: "insulinDosage")
        UserDefaults.standard.set(insulinTimes, forKey: "insulinTimes")
        UserDefaults.standard.set(selectedHeightUnit, forKey: "selectedHeightUnit")
        UserDefaults.standard.set(selectedWeightUnit, forKey: "selectedWeightUnit")
        // For profile image, convert UIImage to Data for storage
        if let profileImage = profileImage, let imageData = profileImage.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: "profileImage")
        }
        UserDefaults.standard.set(medications, forKey: "medications")
        print("Profile saved")
        
        isProfilePresented = false
    }
    
    // MARK: - Load Profile Data
    private func loadProfileData() {
        diabetesType = UserDefaults.standard.string(forKey: "diabetesType")
        height = UserDefaults.standard.string(forKey: "height") ?? ""
        weight = UserDefaults.standard.string(forKey: "weight") ?? ""
        insulinType = UserDefaults.standard.string(forKey: "insulinType")
        insulinDosage = UserDefaults.standard.string(forKey: "insulinDosage") ?? ""
        insulinTimes = UserDefaults.standard.string(forKey: "insulinTimes") ?? ""
        selectedHeightUnit = UserDefaults.standard.string(forKey: "selectedHeightUnit") ?? "cm"
        selectedWeightUnit = UserDefaults.standard.string(forKey: "selectedWeightUnit") ?? "kg"
        // Load profile image if exists
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let image = UIImage(data: imageData) {
            profileImage = image
        }
        // Load medications list
        medications = UserDefaults.standard.stringArray(forKey: "medications") ?? []
        print("Profile loaded")
    }
    
    // MARK: - Profile Image Section
    struct ProfileImageSection: View {
        @Binding var profileImage: UIImage?
        @Binding var showImagePicker: Bool
        
        var body: some View {
            VStack {
                Button(action: {
                    self.showImagePicker.toggle()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 100)
                        
                        if let profileImage = profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                        } else {
                            Image(systemName: "camera")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(isPresented: $showImagePicker, image: $profileImage)
                }
            }
            .padding(.top, 16)
        }
    }
    
    // MARK: - Personal Information Section
    struct PersonalInformationSection: View {
        @Binding var diabetesType: String?
        @Binding var height: String
        @Binding var weight: String
        @Binding var selectedHeightUnit: String
        @Binding var selectedWeightUnit: String
        var bmi: Double  // Pass bmi as a regular value
        
        let diabetesTypes = ["Type 1", "Type 2", "Gestational", "Pre-Diabetes"]
        let heightUnits = ["cm", "inches"]
        let weightUnits = ["kg", "lbs"]
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                SectionHeader(title: "Personal Information")
                
                PickerWithLabel(label: "Diabetes Type", selection: $diabetesType, options: diabetesTypes)
                
                Divider().padding(.horizontal)
                
                HStack {
                    TextField("Height", text: $height)
                        .keyboardType(.decimalPad)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 10).fill((Color(hex: "#C9D3F5"))))
                        .frame(width: 250)
                    
                    Picker(" ", selection: $selectedHeightUnit) {
                        ForEach(heightUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 100)
                }
                
                Divider().padding(.horizontal)
                
                HStack {
                    TextField("Weight", text: $weight)
                        .keyboardType(.decimalPad)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 10).fill((Color(hex: "#C9D3F5"))))
                        .frame(width: 250)
                    
                    Picker(" ", selection: $selectedWeightUnit) {
                        ForEach(weightUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 100)
                }
                
                Divider().padding(.horizontal)
                
                HStack {
                    Text("BMI")
                        .padding(.leading, 16)
                    Spacer()
                    Text(bmi == 0 ? "" : String(format: "%.2f", bmi))
                        .foregroundColor(bmi < 18.5 ? .yellow : (bmi <= 25.9 ? .green : .red))
                        .padding(.trailing, 16)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).fill((Color(hex: "#C9D3F5"))))
            .padding(.horizontal)
        }
    }
    
    // MARK: - Insulin Information Section
    struct InsulinInformationSection: View {
        @Binding var insulinType: String?
        @Binding var insulinDosage: String
        @Binding var insulinTimes: String
        
        let insulinTypes = ["Basal", "Prandial"]
        
        var body: some View {
            VStack {
                
                SectionHeader(title: "Insulin Information")
                // Insulin Type Picker
                PickerWithLabel(label: "Insulin Type", selection: $insulinType, options: insulinTypes)
                
                Divider().padding(.horizontal)
                
                // TDD (Total Daily Dose)
                HStack {
                    Text("TDD")
                        .padding(.leading, 16)
                    Spacer()
                    TextField("", text: $insulinDosage)
                        .keyboardType(.decimalPad)
                        .padding(.vertical, 12)
                        .padding(.trailing, 16)
                        .background(RoundedRectangle(cornerRadius: 10).fill((Color(hex: "#C9D3F5"))))
                        .frame(width: 60)
                }
                
                Divider().padding(.horizontal)
                
                // Insulin Frequency
                HStack {
                    Text("Insulin Frequency")
                        .padding(.leading, 16)
                    Spacer()
                    TextField("", text: $insulinTimes)
                        .keyboardType(.decimalPad)
                        .padding(.vertical, 12)
                        .padding(.trailing, 16)
                        .background(RoundedRectangle(cornerRadius: 10).fill((Color(hex: "#C9D3F5"))))
                        .frame(width: 60)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).fill((Color(hex: "#C9D3F5"))))
            .padding(.horizontal)
        }
    }
    
    // MARK: - Other Medications Section
    struct OtherMedicationsSection: View {
        @Binding var medicationText: String
        @Binding var medications: [String]
        @Binding var showReminderModal: Bool
        @ObservedObject var reminderManager: ReminderManager
        
        var body: some View {
            VStack {
                // Section Header
                SectionHeader(title: "Medication Reminders")
                    .padding(.leading, 16)
                
                // Medication Input and Plus Button
                HStack {
                    TextField("Enter Medication and Insulin", text: $medicationText)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 10).fill((Color(hex: "#C9D3F5"))))
                        .frame(height: 40)
                        .onSubmit {
                            // Add medication to list if the text field is not empty
                            if !medicationText.isEmpty {
                                medications.append(medicationText)  // Add to list
                                medicationText = ""  // Clear the text field after adding
                            }
                        }
                    
                    Button(action: {
                        // Add medication to list if the text field is not empty
                        if !medicationText.isEmpty {
                            medications.append(medicationText)  // Add to list
                            medicationText = ""  // Clear the text field after adding
                        }
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .foregroundColor((Color(hex: "#1C1345")))
                            .padding(.leading, 16)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                Divider().padding(.horizontal, 16)
                
                // Medication List
                VStack(alignment: .leading) {
                    ForEach(medications, id: \.self) { medication in
                        HStack {
                            Text(medication)
                                .padding(.vertical, 10)
                                .padding(.leading, 16)
                            
                            Spacer()
                            
                            // Button to set a reminder for this medication
                            Button(action: {
                                medicationText = medication
                                showReminderModal = true
                                reminderManager.currentReminder = ReminderDetails(
                                    title: medication,
                                    startDate: Date(),
                                    notes: "",
                                    repetition: .daily,
                                    isBiDaily: false,
                                    secondTime: nil
                                )
                            }) {
                                Image(systemName: "bell.fill")
                                    .foregroundColor(Color(hex: "1C1345"))
                                    .padding(.trailing, 16)
                            }
                            
                            // Delete Button to remove medication
                            Button(action: {
                                if let index = medications.firstIndex(of: medication) {
                                    medications.remove(at: index)
                                }
                            }) {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.red)
                                    .padding(.trailing, 16)
                            }
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill((Color(hex: "#C9D3F5"))))
                .padding(.horizontal, 16)
            }
            .background(RoundedRectangle(cornerRadius: 15).fill((Color(hex: "#C9D3F5"))))
            .padding()
        }
    }
    
    // Custom Section Header (Restored)
    struct SectionHeader: View {
        var title: String
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.headline)
                    .padding(.leading, 16)
                
                Spacer()
            }
            .padding(.top)
            .padding(.bottom, 5)
            .background((Color(hex: "#C9D3F5")))
        }
    }
    
    // Helper View for Picker
    struct PickerWithLabel: View {
        var label: String
        @Binding var selection: String?
        var options: [String]
        
        var body: some View {
            HStack {
                Text(label)
                    .font(.body)
                    .padding(.leading, 16)
                
                Spacer()
                
                Picker("", selection: $selection) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                            .tag(option as String?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 150)
                .padding(.trailing, 16)
            }
            .padding(.vertical, 10)
            .background(RoundedRectangle(cornerRadius: 10).fill((Color(hex: "#C9D3F5"))))
        }
    }
    
    // Helper to dismiss keyboard
    @MainActor private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    Profile(isProfilePresented: .constant(false))
}
