//
//  ExerciseDetailView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 09/03/26.
//

import SwiftUI
import SwiftData

struct ExerciseDetailView: View {
    @Bindable var exercise: ExerciseTemplate
    @State private var showingEdit = false

    var body: some View {
        List {
            Section("Exercise") {
                VStack(alignment: .leading, spacing: 8) {
                    Text(exercise.name)
                        .font(.headline)

                    HStack(spacing: 12) {
                        Text("\(exercise.targetSets) sets")

                        if exercise.toFailure {
                            Text("To failure")
                        } else if let reps = exercise.targetReps {
                            Text("\(reps) reps")
                        }

                        Text("Rest \(exercise.restSeconds)s")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                    if let notes = exercise.notes {
                        Text(notes)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }

            Section {
                Button("Edit Exercise") {
                    showingEdit = true
                }
            }

            Section("Recent History") {
                ExerciseHistoryContentView(
                    exerciseTemplateId: exercise.id,
                    limit: 3
                )

                NavigationLink {
                    FullExerciseHistoryView(
                        exerciseName: exercise.name,
                        exerciseTemplateId: exercise.id
                    )
                } label: {
                    Text("See full history")
                        .font(.headline)
                }
            }
        }
        .navigationTitle(exercise.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingEdit) {
            EditExerciseView(exercise: exercise)
        }
    }
}
