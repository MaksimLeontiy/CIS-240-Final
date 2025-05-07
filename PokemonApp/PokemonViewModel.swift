//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by LEONTIY, MAKSIM M. on 4/28/25.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var sprites: [String: String] = [:]
    
    // Function to fetch each pokemons name and url for the home page
    func fetchPokemon(){
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {
            print("Invalid URL for fetching pokemons")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in if let data = data {
            do {
                let decodedResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.pokemons = decodedResponse.results
                    self.fetchSprites()
                }
            } catch {
                print("Decoding Error: \(error)")
            }
        } else if let error = error {
            print("HTTP Request Failed: \(error)")
        }
        }.resume()
    }
    // Function to fetch each pokemons sprite to display on the home page
    func fetchSprites() {
        for pokemon in pokemons {
            guard let url = URL(string: pokemon.url) else {
                print("Invalid URL for sprite")
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in if let data = data {
                do{
                    let detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                    
                    if let imageUrl = detail.sprites.front_default {
                        DispatchQueue.main.async {
                            self.sprites[pokemon.name] = imageUrl
                        }
                    }
                } catch{
                    print("Decoding Error for sprite: \(error)")
                }
            } else if let error = error {
                print("HTTP Request Failed for sprite: \(error)")
            }
            }.resume()
        }
    }
    // Function to search for specific pokemon
    func searchPokemon(name: String) {
        let lowercasedName = name.lowercased()
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(lowercasedName)") else {
            print("Invalid URL for search")
            return
        }
        print("Fetching Pokémon: \(name)")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("Finished request for: \(name)")
            if let data = data {
                do {
                    let detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                    DispatchQueue.main.async {
                        let pokemon = Pokemon(name: lowercasedName, url: "https://pokeapi.co/api/v2/pokemon/\(lowercasedName)")
                        self.pokemons = [pokemon]
                        if let imageUrl = detail.sprites.front_default {
                            self.sprites[pokemon.name] = imageUrl
                        }
                        print(pokemon)
                    }
                } catch {
                    print("Decoding error for search: \(error)")
                }
            } else if let error = error {
                print("HTTP Request Failed for search: \(error)")
            }
        }.resume()
    }
}
