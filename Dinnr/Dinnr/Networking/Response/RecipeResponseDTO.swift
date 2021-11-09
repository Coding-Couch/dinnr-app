//
//  RecipeResponseDTO.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-09.
//

import Foundation

struct RecipeResponseDTO: Decodable {
    let currentOffset: Int
    let totalCount: Int
    let recipes: [Recipe]
}
