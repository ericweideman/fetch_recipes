//
//  RecipesAPI_Tests.swift
//  Fetch_Recipes
//
//  Created by Eric Weideman on 10/25/24.
//

import XCTest
@testable import Fetch_Recipes

final class RecipesAPITests: XCTestCase {
    
    func testValidURLWithRecipes() async throws {
        let validURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        let recipes = try await RecipesAPI.getRecipies(validURL)
        
        XCTAssertFalse(recipes.isEmpty, "Expected non-empty recipes array")
    }
    
    func testInvalidURL() async {
        do {
            _ = try await RecipesAPI.getRecipies("Invalid URL")
            XCTFail("Expected to throw NetworkError.invalidURL")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidURL)
        } catch {
            XCTFail("Expected NetworkError.invalidURL, got \(error)")
        }
    }
    
    func testValidURLWithNoData() async {
 
        let urlWithNoRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        
        do {
            _ = try await RecipesAPI.getRecipies(urlWithNoRecipes)
            XCTFail("Expected to throw NetworkError.noData")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .noData)
        } catch {
            XCTFail("Expected NetworkError.noData, got \(error)")
        }
    }
    
    func testDataError() async {
        let urlWithInvalidData = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        
        do {
            _ = try await RecipesAPI.getRecipies(urlWithInvalidData)
            XCTFail("Expected to throw NetworkError.dataError")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .dataError)
        } catch {
            XCTFail("Expected NetworkError.dataError, got \(error)")
        }
    }
}
