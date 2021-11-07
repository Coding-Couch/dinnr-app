//
//  Ingredient.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-05.
//

import Foundation
import SwiftUI

struct Ingredient: Identifiable, Codable, Hashable {
    let id: UUID = UUID()
    var name: String
    var image: URL?
    var amount: Double
    var unit: IngredientAmountType
    
    init(name: String, amount: Double, unit: IngredientAmountType, image: URL? = nil) {
        self.name = name
        self.amount = amount
        self.unit = unit
        self.image = image
    }
    
    init() {
        self.name = ""
        self.amount = 0.0
        self.unit = .count
    }
}

enum IngredientAmountType: CustomStringConvertible, Hashable, Identifiable, Codable {
    var description: String {
        switch self {
        case .mass(let massUnit):
            return massUnit.rawValue
        case .volume(let volumeUnit):
            return volumeUnit.rawValue
        case .count:
            return "Count"
        }
    }
    
    case mass(massUnit: IngredientMassUnit)
    case volume(volumeUnit: IngredientVolumeUnit)
    case count
    
    var id: UUID { UUID() }
    
    static var allMassUnits: [IngredientAmountType] {
        IngredientMassUnit.allCases.map { massUnit in
            return .mass(massUnit: massUnit)
        }
    }
    
    static var allVolumeUnits: [IngredientAmountType] {
        IngredientVolumeUnit.allCases.map { volumeUnit in
            return .volume(volumeUnit: volumeUnit)
        }
    }
}

enum IngredientMassUnit: String, CaseIterable, Codable {
    case kilograms = "Kilograms"
    case grams = "Grams"
    case milligrams = "Milligrams"
    case ounces = "Ounces"
    case pounds = "lbs"
    case stones = "Stones"
    
    var unit: UnitMass {
        switch self {
        case .kilograms:
            return .kilograms
        case .grams:
            return .grams
        case .milligrams:
            return .milligrams
        case .ounces:
            return .ounces
        case .pounds:
            return .pounds
        case .stones:
            return .stones
        }
    }
}

enum IngredientVolumeUnit: String, CaseIterable, Codable {
    case liters = "Liters"
    case milliliters = "Milliliters"
    case bushels = "Bushels"
    case teaspoons = "Teaspoons"
    case tablespoons = "Tablespoons"
    case fluidOunces = "Fluid Ounces"
    case cups = "Cups"
    case pints = "Pints"
    case quarts = "Quarts"
    case gallons = "Gallons"
    case metricCups = "Metric Cups"
    
    var unit: UnitVolume {
        switch self {
        case .liters:
            return .liters
        case .milliliters:
            return .milliliters
        case .bushels:
            return .bushels
        case .teaspoons:
            return .teaspoons
        case .tablespoons:
            return .tablespoons
        case .fluidOunces:
            return .fluidOunces
        case .cups:
            return .cups
        case .pints:
            return .pints
        case .quarts:
            return .quarts
        case .gallons:
            return .gallons
        case .metricCups:
            return .metricCups
        }
    }
}
