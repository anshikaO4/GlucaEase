import SwiftUI

struct TabOne: View {
    @State private var isAddButtonTappedBloodPressure = false
    @State private var isAddButtonTappedBloodSugar = false
    
    @State private var bloodPressureLevel: (systolic: Double?, diastolic: Double?) = (nil, nil)
    @State private var bloodPressureHistory: [(systolic: Double, diastolic: Double)] = []
    
    @State private var bloodSugarLevel: Double? = nil
    @State private var bloodSugarHistory: [Double] = []
    
    @EnvironmentObject var reminderManager: ReminderManager
    
    @StateObject var dataController = articlesDataController()
    
    var body: some View {
//        ZStack{
        ScrollView {
            VStack(spacing: 20) {
                // Medication Section
                VStack(alignment: .leading) {
                    Text("Medications")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                        .foregroundColor(Color(hex:"1C1345"))
                    
                    MedicationCard(reminderManager: reminderManager)
                }
                        .padding(.top, 20 )
                    
                    // Health Section
                    VStack(alignment: .leading) {
                        Text("Health")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex:"1C1345"))
                        
                        // Blood sugar and blood pressure cards
                        BloodSugarCard(isAddButtonTapped: $isAddButtonTappedBloodSugar, bloodSugarLevel: $bloodSugarLevel, bloodSugarHistory: $bloodSugarHistory)
                            .padding(.top, 10)
                        
                        BPCard(isAddButtonTapped: $isAddButtonTappedBloodPressure, bloodPressureLevel: $bloodPressureLevel, bloodPressureHistory: $bloodPressureHistory)
                            .padding(.top, 10)
                    }
//                    .padding(.top, 80)
                
                VStack(alignment: .leading){
                    Text("Articles")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                        .foregroundColor(Color(hex:"1C1345"))
                    
                    // Use the articles from the dataController
                    ArticlesCard()
                        .padding(.horizontal, 16)
                        .environmentObject(dataController) 
                    
                }
//                .padding(.top, 20 )
                }
            }
//        .background(
//            LinearGradient(gradient: Gradient(colors: [Color(hex:"#494CA1"), Color(hex:"#F2F2F2")]), startPoint: .top, endPoint: .bottom)
//            )
        .background(Color(hex: "#E0E3F0"))
            .overlay(
                ZStack {
                    // Blur background when any popup is active
                    if isAddButtonTappedBloodPressure || isAddButtonTappedBloodSugar {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .blur(radius: 10)
                    }
                    
                    // Blood Pressure Popup
                    if isAddButtonTappedBloodPressure {
                        BloodPressurePopup(
                            isAddButtonTapped: $isAddButtonTappedBloodPressure,
                            bloodPressureLevel: $bloodPressureLevel,
                            bloodPressureHistory: $bloodPressureHistory // Add this line
                        )
                        .transition(.scale) // Optional: for animation
                    }
                    
                    // Blood Sugar Popup
                    if isAddButtonTappedBloodSugar {
                        BloodSugarPopup(
                            isAddButtonTapped: $isAddButtonTappedBloodSugar,
                            bloodSugarLevel: $bloodSugarLevel,
                            bloodSugarHistory: $bloodSugarHistory // Add this line
                        )
                        .transition(.scale) // Optional: for animation
                    }
                    
                }
            )
        }
        
}
