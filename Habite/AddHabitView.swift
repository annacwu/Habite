//
//  AddHabitView.swift
//  Habite
//
//  Created by Anna Wu on 9/9/24.
//

import SwiftUI

struct AddHabitView: View {
    @State private var habit = ""
    @State private var frequency = Date()
    
    var body: some View {
        NavigationStack{
            VStack{
                Form {
                    TextField("Habit", text: $habit)
                    DatePicker("Frequency", selection: $frequency)
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                Form{
                    Button("Save"){
//                        dismiss()
                    }
                }
            }
            .navigationTitle("Add New Habit")
        }
    }
}

#Preview {
    AddHabitView()
}
