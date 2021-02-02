//
//  Models.swift
//  City-Search
//
//  Created by Mathew Thomas on 02/02/2021.
//

import Foundation

// MARK: - City
struct City: Codable {
    let country, name: String
    let _id: Int
    let coord: Coord

    enum CodingKeys: String, CodingKey {
        case country, name
        case _id
        case coord
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}
