//
//  Instruction.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-05.
//

import Foundation

struct Instruction: Identifiable, Hashable, Codable {
    var step: Int
    var image: URL?
    var description: String = ""

    var id: Int { step }

    var displayString: String {
        "\(step). \(description)"
    }
}
