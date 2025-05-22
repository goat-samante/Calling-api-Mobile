//
//  Competition.swift
//  Calling api Mobile
//
//  Created by Samuel Amante on 5/21/25.
//

import Foundation

struct CompetitionsResponse: Codable {
    let count: Int
    let competitions: [Competition]
}

struct Competition: Codable, Identifiable {
    let id: Int
    let name: String
    let area: Area
    let code: String?
    let type: String
    let plan: String?
    let currentSeason: Season?
}

struct Area: Codable {
    let name: String
    let code: String?
}

struct Season: Codable {
    let startDate: String
    let endDate: String
    let currentMatchday: Int?
}

