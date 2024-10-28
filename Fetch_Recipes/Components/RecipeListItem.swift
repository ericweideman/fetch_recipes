//
//  RecipeListItem.swift
//  Fetch_Recipes
//
//  Created by Eric Weideman on 10/24/24.
//

import SwiftUI

struct RecipeListItem: View {
    let recipe: Recipe
    

    var body: some View {
        VStack{
            HStack {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                .padding(.leading, 10)
                Spacer()
                Text("Type: \(recipe.cuisine)")
                    .font(.caption)
                    .foregroundColor(.primary)
                .padding(.trailing, 20)
            }
            .padding(.bottom, 5)
            
            RecipeListItemIcon(imageUrlString: recipe.photoUrlLarge ?? "")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
