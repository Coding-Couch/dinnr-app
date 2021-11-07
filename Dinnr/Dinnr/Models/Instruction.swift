//
//  Instruction.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-05.
//

import Foundation

struct Instruction: Identifiable, Codable, Hashable {
    let id: UUID
    var image: URL?
    var description: String
}
