//
//  ExerciseHistoryView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 09/03/26.
//

import SwiftUI
import SwiftData

struct ExerciseHistoryView: View {
    let exerciseName: String

    @Query(sort: \WorkoutSession.performedAt, order: .reverse)
    private var sessions: [WorkoutSession]

    private var matchingExerciseSessions: [(session: WorkoutSession, exercise: ExerciseSession)] {
        sessions.compactMap { session in
            guard let exercise = session.exerciseSessions.first(where: { $0.exerciseName == exerciseName }) else {
                return nil
            }
            return (session, exercise)
        }
    }

    var body: some View {
        List {
            if matchingExerciseSessions.isEmpty {
                ContentUnavailableView(
                    "No history yet",
                    systemImage: "chart.line.uptrend.xyaxis",
                    description: Text("Complete this exercise in a workout to see progress here.")
                )
            } else {
                ForEach(matchingExerciseSessions, id: \.session.id) { item in
                    Section {
                        let sortedSets = item.exercise.sets.sorted { $0.setNumber < $1.setNumber }

                        if sortedSets.isEmpty {
                            Text("No sets recorded")
                                .foregroundStyle(.secondary)
                        } else {
                            ForEach(sortedSets) { set in
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
                            Text(item.session.performedAt.formatted(date: .abbreviated, time: .shortened))
                                .font(.headline)

                            HStack(spacing: 12) {
                                Text("\(item.exercise.targetSets) sets")

                                if item.exercise.toFailure {
                                    Text("To failure")
                                } else if let reps = item.exercise.targetReps {
                                    Text("Target: \(reps) reps")
                                }

                                Text("Rest: \(item.exercise.restSeconds)s")
                            }
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                            if let notes = item.exercise.notes {
                                Text(notes)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .textCase(nil)
                    }
                }
            }
        }
        .navigationTitle(exerciseName)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formatWeight(_ value: Double) -> String {
        if value == floor(value) {
            return String(Int(value))
        }
        return String(value)
    }
}
