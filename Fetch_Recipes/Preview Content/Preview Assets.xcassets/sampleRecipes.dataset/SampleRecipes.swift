//
//  sampleRecipes.swift
//  Fetch_Recipes
//
//  Created by Eric Weideman on 10/24/24.
//

import Foundation

let sampleRecipes: [Recipe] = [
    Recipe(
        id: UUID().uuidString,
        cuisine: "Italian",
        name: "Spaghetti Carbonara",
        photoUrlLarge: "https://example.com/spaghetti_large.jpg",
        photoUrlSmall: "https://example.com/spaghetti_small.jpg",
        sourceUrl: "https://example.com/spaghetti-recipe",
        youtubeUrl: "https://youtube.com/spaghetti-carbonara"
    ),
    Recipe(
        id: UUID().uuidString,
        cuisine: "Mexican",
        name: "Tacos al Pastor",
        photoUrlLarge: "https://example.com/tacos_large.jpg",
        photoUrlSmall: "https://example.com/tacos_small.jpg",
        sourceUrl: "https://example.com/tacos-recipe",
        youtubeUrl: "https://youtube.com/tacos-al-pastor"
    ),
    Recipe(
        id: UUID().uuidString,
        cuisine: "Japanese",
        name: "Sushi Rolls",
        photoUrlLarge: "https://example.com/sushi_large.jpg",
        photoUrlSmall: "https://example.com/sushi_small.jpg",
        sourceUrl: "https://example.com/sushi-recipe",
        youtubeUrl: "https://youtube.com/sushi-rolls"
    )
]
