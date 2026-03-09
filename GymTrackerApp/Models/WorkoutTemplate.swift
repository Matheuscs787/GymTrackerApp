//
//  WorkoutTemplate.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import Foundation
import SwiftData

@Model
final class WorkoutTemplate {
    var id: UUID
    var name: String
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \ExerciseTemplate.workoutTemplate)
    var exercises: [ExerciseTemplate]

    init(
        id: UUID = UUID(),
        name: String,
        createdAt: Date = .now,
        exercises: [ExerciseTemplate] = []
    ) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.exercises = exercises
    }
}
