//
//  HabiteApp.swift
//  Habite
//
//  Created by Anna Wu on 8/25/24.
//

import SwiftUI

@main
struct HabiteApp: App {
    @StateObject private var habitManager = HabitManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(habitManager)
        }
    }
}
