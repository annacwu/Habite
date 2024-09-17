//
//  HomeView.swift
//  Habite
//
//  Created by Anna Wu on 9/9/24.
//

import SwiftUI

struct HomeView: View {
    @State private var habits = [String]()
    @State private var showingAddHabitView = false
    
    var body: some View {
        NavigationStack {
            List {}
            .navigationTitle("Home")
            .toolbar{
                Button("New Habit", systemImage: "plus") {
                    showingAddHabitView = true
                }
            }
            .sheet(isPresented: $showingAddHabitView) {
                AddHabitView()
            }
        }
    }
}

#Preview {
    HomeView()
}
