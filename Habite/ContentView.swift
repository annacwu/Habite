//
//  ContentView.swift
//  Habite
//
//  Created by Anna Wu on 9/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StatsView()
                .tabItem {
                    Label("History", systemImage: "tray.full")
                }
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FocusView()
                .tabItem {
                    Label("Focus", systemImage: "hourglass")
                }
        }
    }
}

#Preview {
    ContentView()
}

