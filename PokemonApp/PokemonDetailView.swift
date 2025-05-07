//
//  PokemonDetailView.swift
//  PokemonApp
//
//  Created by LEONTIY, MAKSIM M. on 4/30/25.
//

import SwiftUI

struct PokemonDetailView: View {
    
    let pokemon: Pokemon
    @StateObject private var viewModel = PokemonDetailViewModel()
    @StateObject private var favoriteViewModel = FavoriteViewModel()

    @State private var detail: PokemonDetail?
    
    var body: some View {
        
        HStack{
            
            Text(pokemon.url)
                .font(.subheadline)
            
            Button(action: {
                    if favoriteViewModel.containsFavoritePokemon(pokemon) {
                        favoriteViewModel.removeFavoritePokemon(pokemon)
                    } else {
                        favoriteViewModel.addFavoritePokemon(pokemon)
                    }
                }) {
                    Image(systemName: favoriteViewModel.containsFavoritePokemon(pokemon) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
        }
            
        VStack(spacing: 20) {
            if let detail = viewModel.detail {
                
                if let imageUrl = detail.sprites.front_default,
                   let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .image?.resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    }
                }
                
                Text(pokemon.name.capitalized)
                    .bold()
                    .font(.title)
                    .padding(.top)
                
                Text("Base Experience: \(detail.base_experience != 0 ? String(detail.base_experience) : "Unknown")")
                
                Text("Height: \(detail.height != 0 ? String(detail.height) : "Unknown")")
                
                Text("Weight: \(detail.weight != 0 ? String(detail.weight) : "Unknown")")
                
                Divider()
                
                Text("Abilities")
                    .font(.largeTitle)
                
                ForEach(detail.abilities){
                    ability in Text(ability.id)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchDetail(pokemon: pokemon)
        }
    }
}

#Preview {
    let samplePokemon = Pokemon(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/pikachu")
    return PokemonDetailView(pokemon: samplePokemon)
}


