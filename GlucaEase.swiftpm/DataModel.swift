import SwiftUI

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let quantity: String
}

struct Recipe: Identifiable {
    let id = UUID()
    let imageName1 : String
    let imageName2 : String
    let recipeName: String
    let preparationTime: String
    let difficultyLevel: String
    let ingredients: [Ingredient]
    let servings: String
    let preparationPointers: String
    let recipeSteps: String
}


struct ReminderDetails: Hashable, Codable, Identifiable {
    var id = UUID()
    var title: String
    var startDate: Date
    var notes: String
    var repetition: RecurrenceType
    var isBiDaily: Bool
    var secondTime: Date?

   
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(startDate)
        hasher.combine(notes)
        hasher.combine(repetition)
        hasher.combine(isBiDaily)
        hasher.combine(secondTime)
    }

   
    static func ==(lhs: ReminderDetails, rhs: ReminderDetails) -> Bool {
        return lhs.title == rhs.title &&
            lhs.startDate == rhs.startDate &&
            lhs.notes == rhs.notes &&
            lhs.repetition == rhs.repetition &&
            lhs.isBiDaily == rhs.isBiDaily &&
            lhs.secondTime == rhs.secondTime
    }
}


enum RecurrenceType: String, Codable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
}

struct Article: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var image: String
    var content: String
}






