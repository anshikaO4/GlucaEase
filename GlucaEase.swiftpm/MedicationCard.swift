import SwiftUI

struct MedicationCard: View {
    @ObservedObject var reminderManager: ReminderManager
    
    var body: some View {
        ScrollView(.horizontal){
            HStack {
                if reminderManager.reminders.isEmpty {
                    Text("No reminders available")
                        .font(.headline)
                        .foregroundColor(.gray)
                } else {
                    // Iterate over the reminders in the reminderManager
                    ForEach(reminderManager.reminders, id: \.self) { reminder in
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(hex: "C9D3F5"))
                                .frame(width: 293, height: 180)
                                .overlay(
                                    VStack(spacing: 0) {
                                        HStack(alignment: .top, spacing: 20) {
                                            Image(systemName: "pill.fill")
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(Color(hex:"1C1345"))
                                            
                                            VStack{
                                                Text(reminder.title)
                                                    .font(.headline)
                                                    .bold()
                                                    .foregroundColor(Color(hex:"1C1345"))
                                                
                                                Text("Dosage: \(reminder.notes)")
                                                    .font(.subheadline)
                                                    .foregroundColor(Color(hex:"1C1345"))
                                            }
                                            Spacer()
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 70)
                                        .padding(.top, 16)
                                        
                                        Divider()
                                            .padding(.horizontal, 16)
                                            .padding(.bottom, 0)
                                        
                                       
                                        HStack {
                                            Text("Due at")
                                                .font(.subheadline)
                                                .foregroundColor(Color(hex:"1C1345"))
                                            Spacer()
                                            
                                            VStack{
                                               
                                                Text("\(reminder.startDate, formatter: dateFormatter)")
                                                    .font(.subheadline)
                                                    .foregroundColor(Color(hex:"1C1345"))
                                                
                                                
                                                if let secondTime = reminder.secondTime {
                                                    Text("\(secondTime, formatter: dateFormatter)")
                                                        .font(.subheadline)
                                                        .foregroundColor(Color(hex:"1C1345"))
                                                }
                                            }
                                        }
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 16)
                                    }
                                )
                                .gesture(
                                    LongPressGesture().onEnded { _ in
                                        showActionSheet(for: reminder)
                                    }
                                )
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    // Function to show action sheet when long pressed
    private func showActionSheet(for reminder: ReminderDetails) {
        // Creating a UIAlertController to present options for Delete
        let actionSheet = UIAlertController(title: "Reminder Options", message: nil, preferredStyle: .actionSheet)

        // Add Delete action
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            // Delete the reminder using the reminder manager
            self.reminderManager.deleteReminder(reminder: reminder)
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        // Present the action sheet
        UIApplication.shared.windows.first?.rootViewController?.present(actionSheet, animated: true)
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

