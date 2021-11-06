//
//  Recipe.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-05.
//

import Foundation

struct Recipe: Identifiable, Hashable {
    init(id: UUID = UUID(), servings: Int, bannerImage: URL, title: String, prepTime: Int, cookTime: Int, ingredients: [Ingredient], instructions: [Instruction], tags: [String]) {
        self.id = id
        self.servings = servings
        self.bannerImage = bannerImage
        self.title = title
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.ingredients = ingredients
        self.instructions = instructions
        self.tags = tags
    }
    
    init() {
        self.id = UUID()
        self.servings = 0
        self.title = ""
        self.prepTime = 0
        self.cookTime = 0
        self.ingredients = [Ingredient()]
        self.instructions = []
        self.tags = []
    }
    
    let id: UUID
    var servings: Int
    var bannerImage: URL?
    var title: String
    var prepTime: Int
    var cookTime: Int
    var ingredients: [Ingredient]
    var instructions: [Instruction]
    var tags: [String] // eg. vegan, keto, etc...
    
    mutating func addIngredient() {
        self.ingredients.append(Ingredient())
    }
    
    mutating func remove(index: Int) {
        self.ingredients.remove(at: index)
    }
    
    mutating func addInstruction() {
        let step = instructions.count + 1
        let instruction = Instruction(step: step)
        self.instructions.append(instruction)
    }
}
