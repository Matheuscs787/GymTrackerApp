//
//  WorkoutSession.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import Foundation
import SwiftData

@Model
final class WorkoutSession {
    var id: UUID
    var workoutName: String
    var performedAt: Date
    var completed: Bool
    var createdAt: Date

    var workoutTemplate: WorkoutTemplate?

    @Relationship(deleteRule: .cascade, inverse: \ExerciseSession.workoutSession)
    var exerciseSessions: [ExerciseSession]

    init(
        id: UUID = UUID(),
        workoutName: String,
        performedAt: Date = .now,
        completed: Bool = false,
        createdAt: Date = .now,
        workoutTemplate: WorkoutTemplate? = nil,
        exerciseSessions: [ExerciseSession] = []
    ) {
        self.id = id
        self.workoutName = workoutName
        self.performedAt = performedAt
        self.completed = completed
        self.createdAt = createdAt
        self.workoutTemplate = workoutTemplate
        self.exerciseSessions = exerciseSessions
    }
}
