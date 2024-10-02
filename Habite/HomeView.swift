//
//  HomeView.swift
//  Habite
//
//  Created by Anna Wu on 9/9/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var habitManager: HabitManager
    @State private var showingAddHabitView = false
    
    let newHabit = Habit(name: "test", description: "testing", duration: TimeInterval(), frequency: HabitFrequency.timesPerWeek(3))

    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("To do Today")){
                    ForEach(habitManager.habits.filter { doToday(habit: $0) }) { habit in
                        Text(habit.name)
                    }
                }
            }
            List{
                Section(header: Text("All habits")) {
                    ForEach(habitManager.habits) { habit in
                        Text(habit.name)
                    }
                }
            }
            .navigationTitle("Home")
            .toolbar{
                Button("New Habit", systemImage: "plus") {
                    showingAddHabitView = true
                }
            }
            .sheet(isPresented: $showingAddHabitView) {
                AddHabitView()
            }
            .onAppear {
                habitManager.addHabit(newHabit)
            }
        }
    }
}

// to customize how i want habits to be displayed
struct HabitRow: View {
    var habit: Habit
    
    var body: some View {
        Text(habit.name)
    }
}

func doToday(habit: Habit) -> Bool {
    let today = Calendar.current.component(.weekday, from: Date()) - 1
    
    switch habit.frequency {
        case .specificDays(let days):
            return days.contains(DayOfWeek(rawValue: today)!)
        case .timesPerWeek:
            return true // FIXME: Add custom logic for handling times per week
    }
}

#Preview {
    HomeView()
        .environmentObject(HabitManager())
}
