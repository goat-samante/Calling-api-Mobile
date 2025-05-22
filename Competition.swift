//
//  Competition.swift
//  Calling api Mobile
//
//  Created by Samuel Amante on 5/21/25.
//

import Foundation

struct CompetitionsResponse: Codable {
    let competitions: [Competition]
}

struct Competition: Codable, Identifiable {
    let id: Int
    let name: String
    let area: Area
    let code: String?
    let plan: String?
}

struct Area: Codable {
    let name: String
}

