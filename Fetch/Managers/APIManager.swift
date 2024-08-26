//
//  APIManager.swift
//  Fetch
//
//  Created by Taylor Smith on 8/23/24.
//

import Foundation

/// Main API Actions
enum MealAPI {
    static let baseURL = "https://www.themealdb.com/api/json/v1/1"
    
    case fetchAllCategories
    case fetchListByCategory(any CategoryRepresentable)
    case fetchMealById(String)
}

/// Main API paths
extension MealAPI {
    var path: String {
        switch self {
        case .fetchAllCategories:
            return "/categories.php"
        case .fetchListByCategory(let category):
            return "/filter.php?c=\(category.name)"
        case .fetchMealById(let id):
            return "/lookup.php?i=\(id)"
        }
    }
    
    var url: URL? {
        URL(string: MealAPI.baseURL + path)
    }
}

class APIManager {    
    private func performRequest<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        return decodedResponse
    }
    
    enum ServiceError: LocalizedError {
         case invalidURL
         case noData
        
        var title: String {
            "Uh Oh!"
        }
        
        var failureReason: String? {
            switch self {
            case .invalidURL:
                "We can't read that!"
            case .noData:
                "There was a problem."
            }
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .invalidURL:
                "Please check the url."
            case .noData:
                "Something went wrong with mealsDB!"
            }
        }
     }
}

extension APIManager {
    func fetchAllCategories() async throws -> Categories {
        guard let url = MealAPI.fetchAllCategories.url else {
            throw ServiceError.invalidURL
        }
        
        do {
            let response: CategoriesResponse = try await performRequest(url: url)
            return response.categories
        } catch {
            throw MealsError(type: ServiceError.noData)
        }
    }
    
    func fetchMealsByCategory(_ category: any CategoryRepresentable) async throws -> Meals {
        guard let url = MealAPI.fetchListByCategory(category).url else {
            throw ServiceError.invalidURL
        }
        
        do {
            let response: MealsResponse = try await performRequest(url: url)
            return response.meals
        } catch {
            throw MealsError(type: ServiceError.noData)
        }
    }
    
    func fetchMealById(_ id: String) async throws -> Meal {
        guard let url = MealAPI.fetchMealById(id).url else {
            throw ServiceError.invalidURL
        }
        
        let response: MealsResponse = try await performRequest(url: url)
        
        if let foundMeal = response.meals.first {
            return foundMeal
        } else {
            throw ServiceError.noData
        }
    }
}

struct MealsError: Error {
    let type: LocalizedError
    
    var title = "Uh Oh!"
    var userMessage: String {
        return "\(type.failureReason ?? "Something went wrong.") \n \(type.recoverySuggestion ?? "Try again later.")"
    }
    
    init(type: LocalizedError) {
        self.type = type
    }
}
