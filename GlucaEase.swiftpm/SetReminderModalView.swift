import SwiftUI
import EventKit

struct SetReminderModalView: View {
    @State private var title: String = ""
    @State private var startDate: Date = Date()
    @State private var notes: String = ""
    @State private var repetition: EKRecurrenceFrequency = .daily
    @State private var isBiDaily: Bool = false
    @State private var secondTime: Date? = nil
    @Binding var isPresented: Bool
    @ObservedObject var reminderManager: ReminderManager
    @State private var showRepetitionPicker: Bool = false
    @State private var newReminder = ReminderDetails(title: "", startDate: Date(), notes: "", repetition: .daily, isBiDaily: false)
    
    
    init(isPresented: Binding<Bool>, reminderManager: ReminderManager, title: String) {
           _isPresented = isPresented
           _reminderManager = ObservedObject(wrappedValue: reminderManager)
           _title = State(initialValue: title)
       }
    
    init(isPresented: Binding<Bool>, reminderManager: ReminderManager, reminder: ReminderDetails) {
        _isPresented = isPresented
        _reminderManager = ObservedObject(wrappedValue: reminderManager)
        _title = State(initialValue: reminder.title)
        _startDate = State(initialValue: reminder.startDate)
        _notes = State(initialValue: reminder.notes)
        _repetition = State(initialValue: convertToEKRecurrenceFrequency(reminder.repetition))
        _isBiDaily = State(initialValue: reminder.isBiDaily)
        _secondTime = State(initialValue: reminder.secondTime)
    }

    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    
                    TextField("Medication Name", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    
                    DatePicker("Date", selection: $startDate, displayedComponents: .date)
                        .padding()
                    
                    DatePicker("First Dose", selection: $startDate, displayedComponents: .hourAndMinute)
                        .padding()
                    
                    
                    TextField("Dosage", text: $notes)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    
                    HStack {
                        Text("Repeat")
                            .font(.body)
                        Spacer()
                        Text(getRepetitionText())
                            .font(.body)
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .onTapGesture {
                        showRepetitionPicker = true
                    }
                    
                    // If Bi-Daily, show second time picker
                    if isBiDaily {
                        DatePicker(" Second DOse", selection: Binding(
                            get: { secondTime ?? Date() },
                            set: { secondTime = $0 }
                        ), displayedComponents: .hourAndMinute)
                        .padding()
                    }
                    
                }
                .background(Color(hex: "#E0E3F0"))
                .padding(.top, -350)
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            isPresented = false
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("Set Reminder")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center) // Centers the title
                    }
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            
                            if !title.isEmpty {
                                let recurrenceType = convertToRecurrenceType(repetition)
                                
                                let reminderDetails = ReminderDetails(
                                    title: title,
                                    startDate: startDate,
                                    notes: notes,
                                    repetition: recurrenceType,
                                    isBiDaily: isBiDaily,
                                    secondTime: secondTime
                                )
                                reminderManager.createReminderEvent(reminderDetails: reminderDetails)
                                isPresented = false
                                
                                
                            } else {
                                print("Title is empty!")
                            }
                        }
                        
                        
                    }
                }
                
                .sheet(isPresented: $showRepetitionPicker) {
                    // Show the repetition picker sheet
                    RepetitionPickerView(
                        selectedRepetition: $repetition,
                        isBiDaily: $isBiDaily,
                        secondTime: $secondTime
                    )
                }
            }
            .background(Color(hex: "#E0E3F0"))
        } .background(Color(hex: "#E0E3F0"))
    }
    
    
    private func getRepetitionText() -> String {
        switch repetition {
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .monthly:
            return "Monthly"
        @unknown default:
            return "Unknown"
        }
    }
}

private func convertToRecurrenceType(_ ekRecurrence: EKRecurrenceFrequency) -> RecurrenceType {
    switch ekRecurrence {
    case .daily:
        return .daily
    case .weekly:
        return .weekly
    case .monthly:
        return .monthly
    @unknown default:
        return .daily
    }
}

private func convertToEKRecurrenceFrequency(_ recurrenceType: RecurrenceType) -> EKRecurrenceFrequency {
    switch recurrenceType {
    case .daily:
        return .daily
    case .weekly:
        return .weekly
    case .monthly:
        return .monthly
    }
}

struct RepetitionPickerView: View {
    @Binding var selectedRepetition: EKRecurrenceFrequency
    @Binding var isBiDaily: Bool
    @Binding var secondTime: Date?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Select Repetition Type")
                .font(.headline)
                .padding()
            
            List {
                Button("Daily") { selectedRepetition = .daily }
                Button("Weekly") { selectedRepetition = .weekly }
                Button("Monthly") { selectedRepetition = .monthly }
            }
            
            Toggle("Second Dose", isOn: $isBiDaily)
                .padding()
            
            if isBiDaily {
                DatePicker("Time", selection: Binding(
                    get: { secondTime ?? Date() },
                    set: { secondTime = $0 }
                ), displayedComponents: .hourAndMinute)
                .padding()
            }
            
            Button("Done") {
                dismiss()
                
            }
            .padding()
        }
        .background(Color(hex: "#E0E3F0"))
    }
}
