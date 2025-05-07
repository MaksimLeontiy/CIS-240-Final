//
//  PokemonResponse.swift
//  PokemonApp
//
//  Created by LEONTIY, MAKSIM M. on 4/28/25.
//

import Foundation

struct PokemonResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Hashable {
    var id: String { name }
    let name: String
    let url: String
}

struct PokemonDetail: Codable {
    let sprites: Sprite
    let height: Int
    let weight: Int
    let base_experience: Int
    let abilities: [Ability]
}

struct Sprite: Codable {
    let front_default: String?
}

struct Ability: Codable, Identifiable {
    var id: String { ability.name }
    let ability: AbilityType
    let is_hidden: Bool
    let slot: Int
}

struct AbilityType: Codable {
    let name: String
}

