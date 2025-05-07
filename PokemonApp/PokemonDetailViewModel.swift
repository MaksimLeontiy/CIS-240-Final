//
//  PokemonDetailViewModel.swift
//  PokemonApp
//
//  Created by LEONTIY, MAKSIM M. on 4/30/25.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var detail: PokemonDetail?

    func fetchDetail(pokemon: Pokemon) {
        guard let url = URL(string: pokemon.url) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(PokemonDetail.self, from: data)
                    DispatchQueue.main.async {
                        self.detail = decoded
                    }
                    print(decoded)
                } catch {
                    print("Decoding error: \(error)")
                }
            } else if let error = error {
                print("HTTP request error: \(error)")
            }
        }.resume()
    }
}

