//
//  WorkoutListView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI
import SwiftData

struct WorkoutListView: View {
    @Environment(\.modelContext) private var context

    @Query(sort: \WorkoutTemplate.createdAt, order: .reverse)
    private var workouts: [WorkoutTemplate]

    @State private var showingCreateWorkout = false

    var body: some View {
        NavigationStack {
            Group {
                if workouts.isEmpty {
                    ContentUnavailableView(
                        "No workouts yet",
                        systemImage: "dumbbell",
                        description: Text("Create your first workout to get started.")
                    )
                } else {
                    List {
                        ForEach(workouts) { workout in
                            NavigationLink {
                                WorkoutDetailView(workout: workout)
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(workout.name)
                                        .font(.headline)

                                    Text("\(workout.exercises.count) exercises")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .onDelete(perform: deleteWorkout)
                    }
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingCreateWorkout = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateWorkout) {
                CreateWorkoutView()
            }
        }
    }

    private func deleteWorkout(at offsets: IndexSet) {
        for index in offsets {
            context.delete(workouts[index])
        }
    }
}
