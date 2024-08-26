//
//  Meal.swift
//  Fetch
//
//  Created by Taylor Smith on 8/23/24.
//

import Foundation

typealias Meals = [Meal]

protocol MealRepresentable: Codable, Identifiable, Equatable, Hashable {
    var id: String { get }
    var name: String { get }
    var drinkAlternate: String? { get }
    var category: String? { get }
    var area: String? { get }
    var instructions: String? { get }
    var thumbnailURL: String { get }
    var tags: String? { get }
    var youtubeURL: String? { get }
    
    // Ingredients and measures (up to 20)
    var ingredient1: String? { get }
    var ingredient2: String? { get }
    var ingredient3: String? { get }
    var ingredient4: String? { get }
    var ingredient5: String? { get }
    var ingredient6: String? { get }
    var ingredient7: String? { get }
    var ingredient8: String? { get }
    var ingredient9: String? { get }
    var ingredient10: String? { get }
    var ingredient11: String? { get }
    var ingredient12: String? { get }
    var ingredient13: String? { get }
    var ingredient14: String? { get }
    var ingredient15: String? { get }
    var ingredient16: String? { get }
    var ingredient17: String? { get }
    var ingredient18: String? { get }
    var ingredient19: String? { get }
    var ingredient20: String? { get }
    
    var measure1: String? { get }
    var measure2: String? { get }
    var measure3: String? { get }
    var measure4: String? { get }
    var measure5: String? { get }
    var measure6: String? { get }
    var measure7: String? { get }
    var measure8: String? { get }
    var measure9: String? { get }
    var measure10: String? { get }
    var measure11: String? { get }
    var measure12: String? { get }
    var measure13: String? { get }
    var measure14: String? { get }
    var measure15: String? { get }
    var measure16: String? { get }
    var measure17: String? { get }
    var measure18: String? { get }
    var measure19: String? { get }
    var measure20: String? { get }
    
    var source: String? { get }
    var imageSource: String? { get }
    var creativeCommonsConfirmed: String? { get }
    var dateModified: String? { get }
    
    var ingredients: [String] { get }
    var measurements: [String] { get }
}

struct MealsResponse: Codable {
    let meals: Meals
}

struct Meal: MealRepresentable {
    let id: String
    let name: String
    let drinkAlternate: String?
    let category: String?
    let area: String?
    let instructions: String?
    let thumbnailURL: String
    let tags: String?
    let youtubeURL: String?
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let ingredient6: String?
    let ingredient7: String?
    let ingredient8: String?
    let ingredient9: String?
    let ingredient10: String?
    let ingredient11: String?
    let ingredient12: String?
    let ingredient13: String?
    let ingredient14: String?
    let ingredient15: String?
    let ingredient16: String?
    let ingredient17: String?
    let ingredient18: String?
    let ingredient19: String?
    let ingredient20: String?
    
    let measure1: String?
    let measure2: String?
    let measure3: String?
    let measure4: String?
    let measure5: String?
    let measure6: String?
    let measure7: String?
    let measure8: String?
    let measure9: String?
    let measure10: String?
    let measure11: String?
    let measure12: String?
    let measure13: String?
    let measure14: String?
    let measure15: String?
    let measure16: String?
    let measure17: String?
    let measure18: String?
    let measure19: String?
    let measure20: String?
    
    let source: String?
    let imageSource: String?
    let creativeCommonsConfirmed: String?
    let dateModified: String?
    
    var instructionsArray: [String]? {
        var seperateByComponent: String {
            (instructions?.contains("\r\n\r\n") ?? false) ? "\r\n\r\n" : "."
        }
        
        if let steps = instructions?.components(separatedBy: seperateByComponent) {
            let trimmed = steps.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            
            return trimmed.filter { $0 != "" }
        }
        
        return nil
    }
    
    var ingredients: [String] {
        return [
            ingredient1, ingredient2, ingredient3, ingredient4, ingredient5,
            ingredient6, ingredient7, ingredient8, ingredient9, ingredient10,
            ingredient11, ingredient12, ingredient13, ingredient14, ingredient15,
            ingredient16, ingredient17, ingredient18, ingredient19, ingredient20
        ].compactMap { $0 }.filter { !$0.isEmpty }
    }
    
    var measurements: [String] {
        return [
            measure1, measure2, measure3, measure4, measure5,
            measure6, measure7, measure8, measure9, measure10,
            measure11, measure12, measure13, measure14, measure15,
            measure16, measure17, measure18, measure19, measure20
        ].compactMap { $0 }.filter { !$0.isEmpty }
    }

    static let mockMeal = Meal(
        id: "53016",
        name: "Chick Fil A Sandwhich",
        drinkAlternate: nil,
        category: "Chicken",
        area: nil,
        instructions: "Wrap the chicken loosely between plastic wrap and pound gently with the flat side of a meat tenderizer until about 1/2 inch thick all around.\r\nCut into two pieces, as even as possible.\r\nMarinate in the pickle juice for 30 minutes to one hour (add a teaspoon of Tabasco sauce now for a spicy sandwich).\r\nBeat the egg with the milk in a bowl.\r\nCombine the flour, sugar, and spices in another bowl.\r\nDip the chicken pieces each into the egg on both sides, then coat in flour on both sides.\r\nHeat the oil in a skillet (1/2 inch deep) to about 345-350.\r\nFry each cutlet for 2 minutes on each side, or until golden and cooked through.\r\nBlot on paper and serve on toasted buns with pickle slices.",
        thumbnailURL: "https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg",
        tags: nil,
        youtubeURL: nil,
        ingredient1: "Chicken Breast",
        ingredient2: "Pickle Juice",
        ingredient3: "Egg",
        ingredient4: "Milk",
        ingredient5: "Flour",
        ingredient6: "Icing Sugar",
        ingredient7: "Paprika",
        ingredient8: "Salt",
        ingredient9: "Black Pepper",
        ingredient10: "Garlic Powder",
        ingredient11: "Celery Salt",
        ingredient12: "Cayenne Pepper",
        ingredient13: "Olive Oil",
        ingredient14: "Sesame Seed burger Buns",
        ingredient15: nil,
        ingredient16: nil,
        ingredient17: nil,
        ingredient18: nil,
        ingredient19: nil,
        ingredient20: nil,
        measure1: "1",
        measure2: "1/4 Cup",
        measure3: "1",
        measure4: "1/4 Cup",
        measure5: "1/2 Cup",
        measure6: "1 tbs",
        measure7: "1/2 tsb",
        measure8: "1/2 tsb",
        measure9: "1/4 tsb",
        measure10: "1/4 tsb",
        measure11: "1/4 tsb",
        measure12: "1/2 tsb",
        measure13: "1 cup",
        measure14: "1",
        measure15: nil,
        measure16: nil,
        measure17: nil,
        measure18: nil,
        measure19: nil,
        measure20: nil,
        source: nil,
        imageSource: nil,
        creativeCommonsConfirmed: nil,
        dateModified: nil
    )
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnailURL = "strMealThumb"
        case tags = "strTags"
        case youtubeURL = "strYoutube"
        
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
        
        case source = "strSource"
        case imageSource = "strImageSource"
        case creativeCommonsConfirmed = "strCreativeCommonsConfirmed"
        case dateModified = "dateModified"
    }
}
