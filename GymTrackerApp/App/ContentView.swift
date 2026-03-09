//
//  ContentView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WorkoutListView()
                .tabItem {
                    Label("Workouts", systemImage: "dumbbell")
                }

            WorkoutHistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
        }
    }
}
