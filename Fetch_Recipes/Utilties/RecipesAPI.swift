//
//  RecipesAPI.swift
//  Fetch_Recipes
//
//  Created by Eric Weideman on 10/24/24.
//

import Foundation
import SwiftUI

enum DataType: CaseIterable {
    case good
    case bad
    case empty
}

enum NetworkError: Error {
    case invalidURL
    case dataError
    case noData
}

class RecipesAPI {
    
    static func getRecipies(_ recipeUrlString: String) async throws -> [Recipe] {
        
        var recipes: [Recipe] = []
        var data: Data = Data()
        
        guard let url = URL(string: recipeUrlString, encodingInvalidCharacters: false) else {
            throw NetworkError.invalidURL
        }
    
        do{
            (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(RecipeResponse.self, from: data)
            recipes = decodedData.recipes
        } catch {
            throw NetworkError.dataError
        }
        
        if(recipes.isEmpty){
            throw NetworkError.noData
        }
        
        return recipes
    }
}

