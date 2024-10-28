//
//  ContentView.swift
//  Fetch_Recipes
//
//  Created by Eric Weideman on 10/23/24.
//

import SwiftUI

enum OverlayMessage {
    case noRecipes
    case dataError
    case none
}

struct HomeView: View {
    @State private var recipes: [Recipe] = []
    @State private var isFirstLogin: Bool = false
    @State private var searchText = ""
    @State private var overlayMsg: OverlayMessage = .none

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
                || $0.cuisine.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            NavigationView{
                VStack(spacing: 0) {
                    HeaderBar(searchText: $searchText)
                    List(filteredRecipes){ recipe in
                        RecipeListItem(recipe: recipe)
                    }
                    .listStyle(.plain)
                    .overlay(
                        Group {
                            if overlayMsg == .noRecipes {
                              Text("No Recipes Found")
                                    .foregroundColor(Color.gray)
                            } else if overlayMsg == .dataError {
                                Text("Encountered Error Loading Recipes")
                                    .foregroundColor(Color.gray)
                            }
                      })
                    .refreshable {
                        await loadRecipes()
                    }
                    .task {
                        await loadRecipes()
                    }
                    .onAppear {
                        checkFirstLogin()
                    }
                    .sheet(isPresented: $isFirstLogin) {
                        WelcomeViewModal(isFirstLogin: $isFirstLogin)
                    }
                }
            }
        }
    }
    
    private func loadRecipes() async {
        let recipesUrlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
       do {
           recipes = []
           overlayMsg = .none
           recipes = try await RecipesAPI.getRecipies(recipesUrlString)
       } catch {
           switch error {
           case NetworkError.dataError:
               overlayMsg = .dataError
               break
           case NetworkError.noData:
               overlayMsg = .noRecipes
               break
           default:
               print("error not successfully caught")
           }
       }
    }
    
    private func checkFirstLogin() {
        if !UserDefaults.standard.bool(forKey: "hasLoggedInBefore") {
            isFirstLogin = true
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

