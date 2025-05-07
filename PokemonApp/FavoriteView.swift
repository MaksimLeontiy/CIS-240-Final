//
//  FavoriteView.swift
//  PokemonApp
//
//  Created by LEONTIY, MAKSIM M. on 5/5/25.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var favoriteViewModel: FavoriteViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(favoriteViewModel.favorites, id: \.id){ pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                        HStack {
                            Text(pokemon.name.capitalized)
                            Spacer()
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}


/*
 #Preview {
 FavoriteView()
 }
 */
