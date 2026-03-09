//
//  ExerciseTemplate.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import Foundation
import SwiftData

@Model
final class ExerciseTemplate {
    var id: UUID
    var name: String
    var order: Int
    var targetSets: Int
    var targetReps: Int?
    var toFailure: Bool
    var restSeconds: Int
    var notes: String?
    var createdAt: Date

    var workoutTemplate: WorkoutTemplate?
    
    var prescriptionSummary: String {
        var parts: [String] = [targetSets.formattedSets]

        if toFailure {
            parts.append("To failure")
        } else if let targetReps {
            parts.append(targetReps.formattedReps)
        }

        parts.append(restSeconds.formattedRest)

        return parts.joined(separator: " • ")
    }

    init(
        id: UUID = UUID(),
        name: String,
        order: Int,
        targetSets: Int,
        targetReps: Int? = nil,
        toFailure: Bool = false,
        restSeconds: Int,
        notes: String? = nil,
        createdAt: Date = .now,
        workoutTemplate: WorkoutTemplate? = nil
    ) {
        self.id = id
        self.name = name
        self.order = order
        self.targetSets = targetSets
        self.targetReps = targetReps
        self.toFailure = toFailure
        self.restSeconds = restSeconds
        self.notes = notes
        self.createdAt = createdAt
        self.workoutTemplate = workoutTemplate
    }
}
