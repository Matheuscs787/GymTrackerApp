//
//  SetEntry.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 08/03/26.
//

import Foundation
import SwiftData

@Model
final class SetEntry {
    var id: UUID
    var setNumber: Int
    var weight: Double
    var reps: Int
    var createdAt: Date

    var exerciseSession: ExerciseSession?

    init(
        id: UUID = UUID(),
        setNumber: Int,
        weight: Double,
        reps: Int,
        createdAt: Date = .now,
        exerciseSession: ExerciseSession? = nil
    ) {
        self.id = id
        self.setNumber = setNumber
        self.weight = weight
        self.reps = reps
        self.createdAt = createdAt
        self.exerciseSession = exerciseSession
    }
}
