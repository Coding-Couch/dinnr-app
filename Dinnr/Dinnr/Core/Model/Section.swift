//
//  Section.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-06.
//

import Foundation
import SwiftUI

/// The Various Sections in the app.
enum Section: Int, Identifiable, Hashable, CaseIterable {
    case recipeCreation
    case recipeSearch
    case settings

    var id: Int {
        self.rawValue
    }

    var localizationKey: LocalizedStringKey {
        switch self {
        case .recipeCreation:
            return .init(stringLiteral: "Section.Title.Create")
        case .recipeSearch:
            return .init(stringLiteral: "Section.Title.Explore")
        case .settings:
            return .init(stringLiteral: "Section.Title.Settings")
        }
    }

    var icon: String {
        switch self {
        case .recipeCreation:
            return "plus"
        case .recipeSearch:
            return "magnifyingglass"
        case .settings:
            return "gearshape"
        }
    }
}
