//
//  RecipeResponseDTO.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-09.
//

struct RecipeResponseDTO: Decodable {
    let currentOffset: Int
    let totalCount: Int
    let recipes: [Recipe]
}
