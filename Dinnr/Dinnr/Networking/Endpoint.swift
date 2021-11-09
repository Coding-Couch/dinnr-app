//
//  Endpoint.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-09.
//

import Foundation

enum Endpoint {
    /// Dinnr Api Base URL
    static let baseUrl: URL = URL(string: "https://dinnr.ca/api/1/")!

    /// Recipe Search path
    ///
    /// Available Query Parameters:
    /// - query: the query string
    /// - offset: the result number to start from
    /// - limit: the number of results to return
    static let recipeSearch = ["search", "recipes"]

    /// Ingredient Search path
    ///
    /// Available Query Parameters:
    /// - query: the query string
    /// - offset: the result number to start from
    /// - limit: the number of results to return
    static let ingredientSearch = ["search", "ingredients"]

    /// Endpoint path for Ingredient Lookup by uuid
    /// - Parameter uuid: The Ingredient UUID
    /// - Returns: Array of path values
    static func ingredientLookup(uuid: UUID) -> [String] {
        return ["ingredients", "\(uuid.uuidString)"]
    }
    
    /// Endpoint path for Ingredient Lookup by uuid
    /// - Parameter uuid: The Ingredient UUID
    /// - Returns: Array of path values
    static func recipeLookup(uuid: UUID) -> [String] {
        return ["recipes", "\(uuid.uuidString)"]
    }
}
