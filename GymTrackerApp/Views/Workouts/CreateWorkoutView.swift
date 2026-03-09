//
//  CreateWorkoutView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI
import SwiftData

struct CreateWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var name = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Workout info") {
                    TextField("Workout name", text: $name)
                }
            }
            .navigationTitle("New Workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveWorkout()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func saveWorkout() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let workout = WorkoutTemplate(name: trimmedName)
        context.insert(workout)

        dismiss()
    }
}
