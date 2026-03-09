//
//  WorkoutDetailView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI
import SwiftData

struct WorkoutDetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.editMode) private var editMode

    @Bindable var workout: WorkoutTemplate
    @State private var showingCreateExercise = false
    @State private var activeSession: WorkoutSession?
    @State private var editingExercise: ExerciseTemplate?

    private var sortedExercises: [ExerciseTemplate] {
        workout.exercises.sorted { $0.order < $1.order }
    }

    var body: some View {
        Group {
            if sortedExercises.isEmpty {
                ContentUnavailableView(
                    "No exercises yet",
                    systemImage: "list.bullet.rectangle",
                    description: Text("Add exercises to build this workout.")
                )
            } else {
                List {
                    Section {
                        Button {
                            startWorkout()
                        } label: {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Start Workout")
                            }
                            .font(.headline)
                        }
                    }

                    Section {
                        ForEach(sortedExercises) { exercise in
                            NavigationLink {
                                ExerciseDetailView(exercise: exercise)
                            } label: {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(exercise.name)
                                        .font(.headline)
                                        .foregroundStyle(.primary)

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
                        }
                        .onDelete(perform: deleteExercise)
                        .onMove(perform: moveExercise)
                    }
                }
            }
        }
        .navigationTitle(workout.name)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                if !sortedExercises.isEmpty {
                    EditButton()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingCreateExercise = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingCreateExercise) {
            CreateExerciseView(workout: workout)
        }
        .sheet(item: $activeSession) { session in
            WorkoutSessionView(session: session)
        }
        .sheet(item: $editingExercise) { exercise in
            EditExerciseView(exercise: exercise)
        }
    }

    private func startWorkout() {
        let session = WorkoutSession(
            workoutName: workout.name,
            workoutTemplate: workout
        )

        context.insert(session)

        for exercise in sortedExercises {
            let exerciseSession = ExerciseSession(
                exerciseTemplateId: exercise.id,
                exerciseName: exercise.name,
                order: exercise.order,
                targetSets: exercise.targetSets,
                targetReps: exercise.targetReps,
                toFailure: exercise.toFailure,
                restSeconds: exercise.restSeconds,
                notes: exercise.notes,
                workoutSession: session
            )

            context.insert(exerciseSession)
            session.exerciseSessions.append(exerciseSession)
        }

        activeSession = session
    }

    private func deleteExercise(at offsets: IndexSet) {
        let exercises = sortedExercises

        for index in offsets {
            context.delete(exercises[index])
        }

        reorderExercises()
    }

    private func moveExercise(from source: IndexSet, to destination: Int) {
        var reordered = sortedExercises
        reordered.move(fromOffsets: source, toOffset: destination)

        for (index, exercise) in reordered.enumerated() {
            exercise.order = index
        }
    }

    private func reorderExercises() {
        let reordered = workout.exercises.sorted { $0.order < $1.order }

        for (index, exercise) in reordered.enumerated() {
            exercise.order = index
        }
    }
}
