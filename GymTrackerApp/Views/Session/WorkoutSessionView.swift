//
//  WorkoutSessionView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI
import SwiftData

struct WorkoutSessionView: View {
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
                                setNumber: setNumber,
                                previousSet: lastSavedSet(for: exercise, setNumber: setNumber)
                            )
                        }
                    } header: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(exercise.exerciseName)
                                .font(.headline)

                            Text(exercise.prescriptionSummary)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            if let notes = exercise.notes, !notes.isEmpty {
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

    private func lastSavedSet(for currentExercise: ExerciseSession, setNumber: Int) -> SetEntry? {
        let previousSessions = allSessions
            .filter { $0.id != session.id }
            .sorted { $0.performedAt > $1.performedAt }

        for workoutSession in previousSessions {
            let matchingExercise = workoutSession.exerciseSessions.first {
                $0.exerciseTemplateId == currentExercise.exerciseTemplateId
            }

            if let matchingExercise {
                let matchingSet = matchingExercise.sets
                    .filter { $0.setNumber == setNumber }
                    .sorted { $0.createdAt > $1.createdAt }
                    .first

                if let matchingSet {
                    return matchingSet
                }
            }
        }

        return nil
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
