//
//  Recipe.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-05.
//

import Foundation

struct Recipe: Identifiable, Codable, Hashable {
    let id: UUID
    var servings: Int
    var bannerImage: URL
    var title: String
    var prepTime: Int
    var cookTime: Int
    var ingredients: [Ingredient]
    var instructions: [Instruction]
    var tags: [String] // eg. vegan, keto, etc...
}
