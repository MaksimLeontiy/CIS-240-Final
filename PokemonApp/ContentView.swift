//
//  ContentView.swift
//  PokemonApp
//
//  Created by LEONTIY, MAKSIM M. on 4/28/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()
    @StateObject private var favoriteViewModel = FavoriteViewModel()
    @State private var searchText: String = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        TabView{
            VStack{
                HStack{
                    Text("Pokemon Index")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                HStack {
                    TextField("Search Pokémon", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button("Search") {
                        viewModel.searchPokemon(name: searchText)
                    }
                    .disabled(searchText.isEmpty)
                    .padding(.trailing)
                }
                
                NavigationStack {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.pokemons) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                    VStack {
                                        if let imageUrl = viewModel.sprites[pokemon.name],
                                           let url = URL(string: imageUrl) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 80, height: 80)
                                            } placeholder: {
                                                ProgressView()
                                                    .frame(width: 80, height: 80)
                                            }
                                        } else {
                                            ProgressView()
                                                .frame(width: 80, height: 80)
                                        }
                                        
                                        Text(pokemon.name.capitalized)
                                            .font(.caption)
                                    }
                                    .padding()
                                }
                            }
                        }
                        .padding()
                    }
                }
                .onAppear {
                    viewModel.fetchPokemon()
                }
            }
            .tabItem {
                Label("Pokémon", systemImage: "pencil")
            }
            
            NavigationStack {
                FavoriteView(favoriteViewModel: favoriteViewModel)
            }
            .onAppear {
                favoriteViewModel.load()
            }
            .tabItem {
                Label("Favorites", systemImage: "heart")
            }
        }
        
        }
    }

#Preview {
    ContentView()
}
