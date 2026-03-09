//
//  GymTrackerApp.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI
import SwiftData

@main
struct GymTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            WorkoutTemplate.self,
            ExerciseTemplate.self,
            WorkoutSession.self,
            ExerciseSession.self,
            SetEntry.self
        ])
    }
}
