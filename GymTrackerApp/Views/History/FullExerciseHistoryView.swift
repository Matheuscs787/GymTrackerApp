//
//  FullExerciseHistoryView.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 09/03/26.
//

import SwiftUI

struct FullExerciseHistoryView: View {
    let exerciseName: String
    let exerciseTemplateId: UUID

    var body: some View {
        List {
            ExerciseHistoryContentView(
                exerciseTemplateId: exerciseTemplateId,
                limit: nil
            )
        }
        .navigationTitle(exerciseName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
