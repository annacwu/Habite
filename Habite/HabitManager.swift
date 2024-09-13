//
//  HabitManager.swift
//  Habite
//
//  Created by Anna Wu on 9/13/24.
//

import Foundation

class HabitManager: ObservableObject {
    @Published var habits: [Habit] = []

    // Add a new habit
    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }

    // Check for habits that need to be completed today
    func habitsForToday() -> [Habit] {
        let today = Calendar.current.component(.weekday, from: Date())
        return habits.filter { habit in
            switch habit.frequency {
            case .specificDays(let days):
                return days.contains(DayOfWeek(rawValue: today - 1)!)
            case .timesPerWeek:
                return true // You can add logic here to spread the habit across the week
            }
        }
    }

    // Track completed habits
    func markHabitAsComplete(_ habit: Habit) {
        var updatedHabit = habit
        updatedHabit.addCompletion(date: Date())
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index] = updatedHabit
        }
    }
}
