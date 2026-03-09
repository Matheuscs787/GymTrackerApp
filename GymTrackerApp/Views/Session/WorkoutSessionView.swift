//
//  WorkoutSessionView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI
import SwiftData

struct WorkoutSessionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Bindable var session: WorkoutSession

    @Query(sort: \WorkoutSession.performedAt, order: .reverse)
    private var allSessions: [WorkoutSession]

    var sortedExercises: [ExerciseSession] {
        session.exerciseSessions.sorted { $0.order < $1.order }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedExercises) { exercise in
                    Section {
                        ForEach(1...exercise.targetSets, id: \.self) { setNumber in
                            SetEntryRowView(
                                exercise: exercise,
                                setNumber: setNumber
                            )
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

                            if let lastSet = lastSavedSet(for: exercise) {
                                Text("Last time: \(formatWeight(lastSet.weight)) kg × \(lastSet.reps)")
                                    .font(.caption)
                                    .foregroundStyle(.blue)
                            } else {
                                Text("No previous data")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

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
            .navigationTitle(session.workoutName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Finish") {
                        session.completed = true
                        dismiss()
                    }
                }

                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        hideKeyboard()
                    }
                }
            }
        }
    }

    private func lastSavedSet(for currentExercise: ExerciseSession) -> SetEntry? {
        let previousSessions = allSessions
            .filter { $0.id != session.id }
            .sorted { $0.performedAt > $1.performedAt }

        for workoutSession in previousSessions {
            let matchingExercises = workoutSession.exerciseSessions
                .filter { $0.exerciseName == currentExercise.exerciseName }
                .sorted { $0.createdAt > $1.createdAt }

            for exercise in matchingExercises {
                let latestSet = exercise.sets
                    .sorted { $0.createdAt > $1.createdAt }
                    .first

                if let latestSet {
                    return latestSet
                }
            }
        }

        return nil
    }

    private func formatWeight(_ value: Double) -> String {
        if value == floor(value) {
            return String(Int(value))
        }
        return String(value)
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
