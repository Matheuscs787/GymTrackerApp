//
//  CreateExerciseView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI
import SwiftData

struct CreateExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    let workout: WorkoutTemplate

    @State private var name = ""
    @State private var targetSets = "3"
    @State private var targetReps = "10"
    @State private var toFailure = false
    @State private var restSeconds = "60"
    @State private var notes = ""

    @FocusState private var focusedField: Field?

    private enum Field {
        case name
        case targetSets
        case targetReps
        case restSeconds
        case notes
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Exercise info") {
                    TextField("Exercise name", text: $name)
                        .focused($focusedField, equals: .name)

                    TextField("Number of sets", text: $targetSets)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .targetSets)

                    Toggle("To failure", isOn: $toFailure)

                    if !toFailure {
                        TextField("Target reps", text: $targetReps)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .targetReps)
                    }

                    TextField("Rest time in seconds", text: $restSeconds)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .restSeconds)

                    TextField("Notes (optional)", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                        .focused($focusedField, equals: .notes)
                }
            }
            .navigationTitle("New Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveExercise()
                    }
                    .disabled(!canSave)
                }

                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
        }
    }

    private var canSave: Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let setsValue = Int(targetSets) ?? 0
        let restValue = Int(restSeconds) ?? 0
        let repsValue = Int(targetReps) ?? 0

        if toFailure {
            return !trimmedName.isEmpty && setsValue > 0 && restValue > 0
        }

        return !trimmedName.isEmpty && setsValue > 0 && restValue > 0 && repsValue > 0
    }

    private func saveExercise() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedNotes = notes.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedName.isEmpty else { return }

        let setsValue = Int(targetSets) ?? 3
        let restValue = Int(restSeconds) ?? 60
        let repsValue = toFailure ? nil : (Int(targetReps) ?? 10)
        let nextOrder = workout.exercises.count

        let exercise = ExerciseTemplate(
            name: trimmedName,
            order: nextOrder,
            targetSets: setsValue,
            targetReps: repsValue,
            toFailure: toFailure,
            restSeconds: restValue,
            notes: trimmedNotes.isEmpty ? nil : trimmedNotes,
            workoutTemplate: workout
        )

        context.insert(exercise)
        workout.exercises.append(exercise)

        dismiss()
    }
}
