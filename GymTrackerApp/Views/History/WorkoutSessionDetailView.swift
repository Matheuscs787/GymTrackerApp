//
//  WorkoutSessionDetailView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI

struct WorkoutSessionDetailView: View {
    let session: WorkoutSession

    private var sortedExercises: [ExerciseSession] {
        session.exerciseSessions.sorted { $0.order < $1.order }
    }

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Text(session.workoutName)
                        .font(.headline)

                    Text(session.performedAt.formatted(date: .abbreviated, time: .shortened))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(session.completed ? "Completed" : "In progress")
                        .font(.caption)
                        .foregroundStyle(session.completed ? .green : .orange)
                }
                .padding(.vertical, 4)
            }

            ForEach(sortedExercises) { exercise in
                Section {
                    if exercise.sets.isEmpty {
                        Text("No sets recorded")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(exercise.sets.sorted { $0.setNumber < $1.setNumber }) { set in
                            HStack {
                                Text("Set \(set.setNumber)")

                                Spacer()

                                Text("\(formatWeight(set.weight)) kg × \(set.reps)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                } header: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(exercise.exerciseName)
                            .font(.headline)

                        HStack(spacing: 12) {
                            Text("\(exercise.targetSets) sets")

                            if exercise.toFailure {
                                Text("To failure")
                            } else if let reps = exercise.targetReps {
                                Text("Target: \(reps) reps")
                            }

                            Text("Rest: \(exercise.restSeconds)s")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                        if let notes = exercise.notes {
                            Text(notes)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .textCase(nil)
                }
            }
        }
        .navigationTitle("Session")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formatWeight(_ value: Double) -> String {
        if value == floor(value) {
            return String(Int(value))
        }
        return String(value)
    }
}
