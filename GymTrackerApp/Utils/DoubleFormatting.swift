//
//  DoubleFormatting.swift
//  GymTrackerApp
//
//  Created by Matheus Souza on 09/03/26.
//

import Foundation

extension Double {
    var formattedWeight: String {
        if self == floor(self) {
            return String(Int(self))
        }
        return String(self)
    }
}
