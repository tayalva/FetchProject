//
//  Category.swift
//  Fetch
//
//  Created by Taylor Smith on 8/23/24.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: Categories
}

protocol CategoryRepresentable: Codable, Identifiable, Equatable, Hashable {
    var id: String { get }
    var name: String { get }
    var thumbnailUrlString: String { get }
    var description: String { get }
}

typealias Categories = [Category]
struct Category: CategoryRepresentable {
    let id: String
    let name: String
    let thumbnailUrlString: String
    let description: String
    
    static let emptyCategory = Category(id: "", name: "", thumbnailUrlString: "", description: "")
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbnailUrlString =  "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}

struct MockDessertCategory: CategoryRepresentable {
    var id: String = "ID"
    var name: String = "Dessert"
    var thumbnailUrlString: String = "thumbnail"
    var description: String = "Cool description"
}
