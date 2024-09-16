//
//  AddHabitView.swift
//  Habite
//
//  Created by Anna Wu on 9/9/24.
//

import SwiftUI

enum FrequencyType: String, CaseIterable, Identifiable {
    case timesPerWeek = "Times per Week"
    case specificDays = "Specific Days"
    
    var id: String { self.rawValue }
}

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var habitManager: HabitManager
    
    @State private var name = ""
    @State private var desc = ""
    @State private var duration = Date()
    @State private var frequencyType: FrequencyType = .timesPerWeek // default
    @State private var timesPerWeek: Int = 3
    @State private var selectedDays: Set<DayOfWeek> = []
    
    var body: some View {
        NavigationStack{
            VStack{
                Form {
                    TextField("Habit Name", text: $name)
                    TextField("Description", text: $desc)
                    
                    // well this super isnt correct
                    DatePicker("Duration", selection: $duration, displayedComponents: [.hourAndMinute])
                                        .datePickerStyle(WheelDatePickerStyle())
                    
                    Picker("How often?", selection: $frequencyType){
                        ForEach(FrequencyType.allCases) { type in // can say all cases because CaseIterable protocol to go through in a foreach
                            Text(type.rawValue).tag(type) // can do type because Identifiable gives it an id to lookup the tag
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if frequencyType == .timesPerWeek {
                        Stepper(value: $timesPerWeek, in: 1...7) {
                            Text("\(timesPerWeek) times per week")
                        }
                    } else {
                        VStack(alignment: .leading) {
                            Text("Select applicable days:")
                            ForEach(DayOfWeek.allCases, id: \.self) { day in
                                DayPickerRow(day: day, isSelected: selectedDays.contains(day)){
                                    if selectedDays.contains(day) {
                                        selectedDays.remove(day)
                                    } else {
                                        selectedDays.insert(day)
                                    }
                                }
                            }
                        }
                    }
                    
                }
                Button("Save"){
                    let timeInterval = duration.timeIntervalSince1970.truncatingRemainder(dividingBy: 86400) // convert to seconds within day
                    let frequency: HabitFrequency
                    
                    if frequencyType == .timesPerWeek {
                        frequency = .timesPerWeek(timesPerWeek)
                    } else {
                        frequency = .specificDays(Array(selectedDays))
                    }
                    
                    let newHabit = Habit(name: name, description: desc, duration: timeInterval, frequency: frequency)
                    habitManager.addHabit(newHabit)
                    dismiss()
                }
            }
            .navigationTitle("Add New Habit")
        }
    }
}

// idk if this is the most efficient way to do this
struct DayPickerRow: View {
    let day: DayOfWeek
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text(day.fullName)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle()) // Make the whole row tappable
        .onTapGesture {
            action()
        }
    }
}



#Preview {
    AddHabitView()
}
