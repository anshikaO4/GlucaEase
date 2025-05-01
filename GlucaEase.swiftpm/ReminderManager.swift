import EventKit
import SwiftUI

class ReminderManager: ObservableObject {
    private var store: EKEventStore
    var isAccessGranted: Bool
    @Published var currentReminder: ReminderDetails?
    @Published var reminders: [ReminderDetails] = []

    // Initialize with Event Store
    init() {
        self.store = EKEventStore()
        self.isAccessGranted = false
        loadReminders() // This will load reminders from UserDefaults when the class is initialized
    }

    // Check and Request Access to Reminders
    @MainActor
    func checkAndRequestAccess() async -> Bool {
        let status = EKEventStore.authorizationStatus(for: .reminder)

        switch status {
        case .authorized:
            print("Access already granted")
            return true
        case .denied:
            print("Access denied")
            return false
        case .notDetermined:
            print("Access not determined, requesting...")
            return await mainRequestAccess()
        case .restricted:
            print("Access restricted")
            return false
        @unknown default:
            print("Unknown authorization status")
            return false
        }
    }

    @MainActor
    private func mainRequestAccess() async -> Bool {
        return await withCheckedContinuation { continuation in
            self.store.requestAccess(to: .reminder) { granted, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error requesting access: \(error.localizedDescription)")
                    }
                    continuation.resume(returning: granted)
                }
            }
        }
    }

    func loadReminders() {
        if let savedData = UserDefaults.standard.data(forKey: "savedReminders"),
           let decodedReminders = try? JSONDecoder().decode([ReminderDetails].self, from: savedData) {
            DispatchQueue.main.async{
                self.reminders = decodedReminders
                print("LReminders count: \(self.reminders.count)")
            }
            
            print("Loaded reminders: \(reminders)")
           
            
        } else {
            print("Failed to load reminders or no saved reminders found.")
        }
    }

    // Save reminders to UserDefaults
    func saveRemindersToDisk() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(reminders) {
            UserDefaults.standard.set(encoded, forKey: "savedReminders")
            
        }
        
    }
    
    func deleteReminder(reminder: ReminderDetails) {
        // Remove the reminder from the list
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders.remove(at: index)
            // Save the updated list back to UserDefaults
            saveRemindersToDisk()
        }
    }

    // Create Reminder Event and ensure updates happen on the main thread
    func createReminderEvent(reminderDetails: ReminderDetails) {
        Task {
            // Check and request access first
            let granted = await checkAndRequestAccess()

            if granted {
                // Proceed to create the reminder on the background thread
                print("Reminder saved:", reminderDetails)
                
                let newEvent = EKEvent(eventStore: store)
                newEvent.title = reminderDetails.title
                newEvent.startDate = reminderDetails.startDate
                newEvent.notes = reminderDetails.notes
                newEvent.endDate = reminderDetails.startDate.addingTimeInterval(60 * 60) // 1-hour duration
                newEvent.calendar = store.defaultCalendarForNewEvents
                

                // Set Recurrence Rule based on user's choice
                let recurrenceRule: EKRecurrenceRule

                switch reminderDetails.repetition {
                case .daily:
                    recurrenceRule = EKRecurrenceRule(recurrenceWith: .daily, interval: 1, end: nil)
                case .weekly:
                    recurrenceRule = EKRecurrenceRule(recurrenceWith: .weekly, interval: 1, end: nil)
                case .monthly:
                    recurrenceRule = EKRecurrenceRule(recurrenceWith: .monthly, interval: 1, end: nil)
                }

                newEvent.addRecurrenceRule(recurrenceRule)

                // If it's bi-daily, create a second reminder with a different time
                if reminderDetails.isBiDaily, let secondTime = reminderDetails.secondTime {
                    let secondEvent = EKEvent(eventStore: store)
                    secondEvent.title = reminderDetails.title
                    secondEvent.startDate = secondTime
                    secondEvent.notes = reminderDetails.notes
                    secondEvent.endDate = secondTime.addingTimeInterval(60 * 60) // 1-hour duration
                    secondEvent.calendar = store.defaultCalendarForNewEvents
                    secondEvent.addRecurrenceRule(recurrenceRule)
                    try? store.save(secondEvent, span: .thisEvent)
                }

                // Save the primary event to the calendar
                do {
                    try store.save(newEvent, span: .thisEvent)
                    print("Reminder successfully saved!")
                    // Ensure we update the reminders array on the main thread
                    DispatchQueue.main.async {
                        withAnimation {
                            self.reminders.append(reminderDetails)
                            self.saveRemindersToDisk()
                            self.loadReminders()
                        }
                        self.objectWillChange.send()  // Manually notify SwiftUI
                    }
                } catch {
                    print("Error saving reminder: \(error)")
                }
            } else {
                print("Permission not granted to access reminders.")
            }
        }
    }
}
