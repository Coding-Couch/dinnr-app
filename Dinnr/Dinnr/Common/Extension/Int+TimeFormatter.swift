//
//  Int+TimeFormatter.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-07.
//

import SwiftUI

extension Int {
    var formattedTime: String {
        let measurement = Measurement(value: Double(self), unit: UnitDuration.seconds)

        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        formatter.unitOptions = .naturalScale
        formatter.unitStyle = .long

        return formatter.string(from: measurement)
    }
}
