//
//  EditExerciseView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI
import SwiftData

struct EditExerciseView: View {
    @Environment(\.dismiss) private var dismiss

    @Bindable var exercise: ExerciseTemplate

    @State private var name: String
    @State private var targetSets: String
    @State private var targetReps: String
    @State private var toFailure: Bool
    @State private var restSeconds: String
    @State private var notes: String

    @FocusState private var focusedField: Field?

    private enum Field {
        case name
        case targetSets
        case targetReps
        case restSeconds
        case notes
    }

    init(exercise: ExerciseTemplate) {
        self.exercise = exercise
        _name = State(initialValue: exercise.name)
        _targetSets = State(initialValue: "\(exercise.targetSets)")
        _targetReps = State(initialValue: exercise.targetReps.map(String.init) ?? "10")
        _toFailure = State(initialValue: exercise.toFailure)
        _restSeconds = State(initialValue: "\(exercise.restSeconds)")
        _notes = State(initialValue: exercise.notes ?? "")
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
            .navigationTitle("Edit Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveChanges()
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

    private func saveChanges() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedNotes = notes.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedName.isEmpty else { return }

        let setsValue = Int(targetSets) ?? exercise.targetSets
        let restValue = Int(restSeconds) ?? exercise.restSeconds
        let repsValue = toFailure ? nil : (Int(targetReps) ?? 10)

        exercise.name = trimmedName
        exercise.targetSets = setsValue
        exercise.targetReps = repsValue
        exercise.toFailure = toFailure
        exercise.restSeconds = restValue
        exercise.notes = trimmedNotes.isEmpty ? nil : trimmedNotes

        dismiss()
    }
}
