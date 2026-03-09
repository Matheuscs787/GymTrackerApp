//
//  IntWorkoutFormatting.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 09/03/26.
//

import Foundation

extension Int {

    var formattedSets: String {
        "\(self) sets"
    }

    var formattedReps: String {
        "\(self) reps"
    }

    var formattedSetNumber: String {
        "Set \(self)"
    }

    var formattedRest: String {
        "Rest \(self)s"
    }
}
