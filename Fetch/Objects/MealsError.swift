//
//  MealsError.swift
//  Fetch
//
//  Created by Taylor Smith on 8/26/24.
//

import Foundation

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
