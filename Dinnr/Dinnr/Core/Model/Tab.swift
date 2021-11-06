//
//  Tab.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-06.
//

import Foundation
import SwiftUI

/// The Various Sections in the app.
enum Tab: Int, Identifiable, Hashable, CaseIterable {
    case recipeCreation
    case recipeSearch
    case settings

    var id: Int {
        self.rawValue
    }

    var localizationKey: LocalizedStringKey {
        switch self {
        case .recipeCreation:
            return .init(stringLiteral: "Tab.Title.Create")
        case .recipeSearch:
            return .init(stringLiteral: "Tab.Title.Explore")
        case .settings:
            return .init(stringLiteral: "Tab.Title.Settings")
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
