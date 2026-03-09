//
//  WorkoutHistoryView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI
import SwiftData

struct WorkoutHistoryView: View {
    @Environment(\.modelContext) private var context

    @Query(sort: \WorkoutSession.performedAt, order: .reverse)
    private var sessions: [WorkoutSession]

    var body: some View {
        NavigationStack {
            Group {
                if sessions.isEmpty {
                    ContentUnavailableView(
                        "No workout history yet",
                        systemImage: "clock.arrow.circlepath",
                        description: Text("Complete a workout session to see it here.")
                    )
                } else {
                    List {
                        ForEach(sessions) { session in
                            NavigationLink {
                                WorkoutSessionDetailView(session: session)
                            } label: {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(session.workoutName)
                                        .font(.headline)

                                    Text(session.performedAt.formatted(date: .abbreviated, time: .shortened))
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)

                                    Text("\(session.exerciseSessions.count) exercises")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .onDelete(perform: deleteSession)
                    }
                }
            }
            .navigationTitle("History")
        }
    }

    private func deleteSession(at offsets: IndexSet) {
        for index in offsets {
            context.delete(sessions[index])
        }
    }
}
