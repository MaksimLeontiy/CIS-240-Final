//
//  FavoriteViewModel.swift
//  PokemonApp
//
//  Created by LEONTIY, MAKSIM M. on 5/5/25.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    
    @Published private var favPokemon: Set<Pokemon> = []
    
    private let key = "pokemon"
    
    var favorites: [Pokemon] {
        Array(favPokemon)
    }
    
    init() {
        load()
    }
    
    func containsFavoritePokemon(_ pokemon: Pokemon) -> Bool {
        return self.favPokemon.contains(pokemon)
    }
    
    func addFavoritePokemon(_ pokemon: Pokemon) {
        self.favPokemon.insert(pokemon)
        print("Favorites after add: \(favPokemon)")
        save()
    }
    
    func removeFavoritePokemon(_ pokemon: Pokemon) {
        self.favPokemon.remove(pokemon)
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(favPokemon)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Failed to save favorites: \(error)")
        }
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        do {
            let decoded = try JSONDecoder().decode(Set<Pokemon>.self, from: data)
            self.favPokemon = decoded
        } catch {
            print("Failed to load favorites: \(error)")
        }
    }
    
    
}
