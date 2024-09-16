//
//  Habit.swift
//  Habite
//
//  Created by Anna Wu on 9/13/24.
//

import Foundation

struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var duration: TimeInterval // Duration per session in seconds
    var frequency: HabitFrequency // How often the user wants to perform it (either by days or number of times per week)
    var completedSessions: [Date] // Track completion times

    init(name: String, description: String, duration: TimeInterval, frequency: HabitFrequency) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.duration = duration
        self.frequency = frequency
        self.completedSessions = []
    }

    mutating func addCompletion(date: Date) {
        completedSessions.append(date)
    }
}

enum HabitFrequency: Codable {
    case specificDays([DayOfWeek]) // Habit occurs on specific days
    case timesPerWeek(Int) // Habit occurs X times per week
}

enum DayOfWeek: Int, Codable, CaseIterable {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    
    var id: Int { self.rawValue }
        
    var fullName: String {
        switch self {
        case .sunday: return "Sunday"
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        }
    }
}
