//
//  ExerciseSession.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import Foundation
import SwiftData

@Model
final class ExerciseSession {
    var id: UUID
    var exerciseTemplateId: UUID
    var exerciseName: String
    var order: Int
    var targetSets: Int
    var targetReps: Int?
    var toFailure: Bool
    var restSeconds: Int
    var notes: String?
    var createdAt: Date

    var workoutSession: WorkoutSession?

    @Relationship(deleteRule: .cascade, inverse: \SetEntry.exerciseSession)
    var sets: [SetEntry]
    
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
        exerciseTemplateId: UUID,
        exerciseName: String,
        order: Int,
        targetSets: Int,
        targetReps: Int? = nil,
        toFailure: Bool = false,
        restSeconds: Int,
        notes: String? = nil,
        createdAt: Date = .now,
        workoutSession: WorkoutSession? = nil,
        sets: [SetEntry] = []
    ) {
        self.id = id
        self.exerciseTemplateId = exerciseTemplateId
        self.exerciseName = exerciseName
        self.order = order
        self.targetSets = targetSets
        self.targetReps = targetReps
        self.toFailure = toFailure
        self.restSeconds = restSeconds
        self.notes = notes
        self.createdAt = createdAt
        self.workoutSession = workoutSession
        self.sets = sets
    }
}
