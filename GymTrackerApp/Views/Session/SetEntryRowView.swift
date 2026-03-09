//
//  SetEntryRowView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import SwiftUI
import SwiftData

struct SetEntryRowView: View {
    @Environment(\.modelContext) private var context

    let exercise: ExerciseSession
    let setNumber: Int
    let previousSet: SetEntry?

    @State private var weight = ""
    @State private var reps = ""

    private var existingSet: SetEntry? {
        exercise.sets.first { $0.setNumber == setNumber }
    }

    private var hasSavedSet: Bool {
        existingSet != nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Set \(setNumber)")
                    .font(.subheadline)
                    .bold()

                Spacer()

                if hasSavedSet {
                    Label("Saved", systemImage: "checkmark.circle.fill")
                        .font(.caption)
                        .foregroundStyle(.green)
                }
            }

            if let previousSet {
                Text("Last time: \(formatWeight(previousSet.weight)) kg × \(previousSet.reps)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 12) {
                TextField("Weight", text: $weight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)

                TextField("Reps", text: $reps)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)

                Button(hasSavedSet ? "Update" : "Save") {
                    saveSet()
                }
                .buttonStyle(.borderedProminent)
                .disabled(!canSave)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
        .onAppear {
            loadExistingValues()
        }
    }

    private var canSave: Bool {
        let parsedWeight = Double(weight.replacingOccurrences(of: ",", with: "."))
        let parsedReps = Int(reps)
        return (parsedWeight ?? 0) > 0 && (parsedReps ?? 0) > 0
    }

    private func loadExistingValues() {
        guard let existingSet else { return }
        weight = formatWeight(existingSet.weight)
        reps = "\(existingSet.reps)"
    }

    private func saveSet() {
        let parsedWeight = Double(weight.replacingOccurrences(of: ",", with: ".")) ?? 0
        let parsedReps = Int(reps) ?? 0

        guard parsedWeight > 0, parsedReps > 0 else { return }

        if let existingSet {
            existingSet.weight = parsedWeight
            existingSet.reps = parsedReps
        } else {
            let set = SetEntry(
                setNumber: setNumber,
                weight: parsedWeight,
                reps: parsedReps,
                exerciseSession: exercise
            )

            context.insert(set)
            exercise.sets.append(set)
        }

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

        hideKeyboard()
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
