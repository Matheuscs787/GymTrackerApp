//
//  ExerciseHistoryContentView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 09/03/26.
//

import SwiftUI
import SwiftData

struct ExerciseHistoryContentView: View {
    let exerciseTemplateId: UUID
    let limit: Int?

    @Query(sort: \WorkoutSession.performedAt, order: .reverse)
    private var sessions: [WorkoutSession]

    private struct HistoryItem: Identifiable {
        let id: UUID
        let session: WorkoutSession
        let exercise: ExerciseSession
    }

    private var matchingExerciseSessions: [HistoryItem] {
        let matches = sessions.compactMap { session -> HistoryItem? in
            guard let exercise = session.exerciseSessions.first(where: { $0.exerciseTemplateId == exerciseTemplateId }) else {
                return nil
            }

            return HistoryItem(
                id: session.id,
                session: session,
                exercise: exercise
            )
        }

        if let limit {
            return Array(matches.prefix(limit))
        }

        return matches
    }

    var body: some View {
        if matchingExerciseSessions.isEmpty {
            ContentUnavailableView(
                "No history yet",
                systemImage: "chart.line.uptrend.xyaxis",
                description: Text("Complete this exercise in a workout to see progress here.")
            )
        } else {
            ForEach(matchingExerciseSessions) { item in
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.session.performedAt.formatted(date: .abbreviated, time: .shortened))
                        .font(.headline)

                    let sortedSets = item.exercise.sets.sorted { $0.setNumber < $1.setNumber }

                    if sortedSets.isEmpty {
                        Text("No sets recorded")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(sortedSets) { set in
                            HStack {
                                Text("Set \(set.setNumber)")
                                Spacer()
                                Text("\(set.weight.formattedWeight) kg × \(set.reps)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .padding(.vertical, 6)
            }
        }
    }
}
