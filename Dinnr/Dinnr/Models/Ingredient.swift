//
//  Ingredient.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-05.
//

import Foundation

struct Ingredient: Identifiable {
    let id: UUID
    var name: String
    var amount: Measurement<UnitVolume>
    var image: URL?
}
